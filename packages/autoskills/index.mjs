#!/usr/bin/env node

import { resolve } from 'node:path'
import { spawn } from 'node:child_process'
import { createInterface } from 'node:readline'
import { detectTechnologies, collectRepos } from './lib.mjs'

// ── ANSI Colors ───────────────────────────────────────────────

const bold = (s) => `\x1b[1m${s}\x1b[22m`
const dim = (s) => `\x1b[2m${s}\x1b[22m`
const green = (s) => `\x1b[32m${s}\x1b[39m`
const yellow = (s) => `\x1b[33m${s}\x1b[39m`
const cyan = (s) => `\x1b[36m${s}\x1b[39m`
const red = (s) => `\x1b[31m${s}\x1b[39m`
const HIDE_CURSOR = '\x1b[?25l'
const SHOW_CURSOR = '\x1b[?25h'

// ── Terminal UI ───────────────────────────────────────────────

function prompt(question) {
  if (!process.stdin.isTTY) return Promise.resolve('y')
  const rl = createInterface({ input: process.stdin, output: process.stdout })
  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      rl.close()
      resolve(answer.trim().toLowerCase())
    })
  })
}

function printBanner() {
  console.log()
  console.log(bold(cyan('   ╔═══════════════════════════════════════╗')))
  console.log(bold(cyan('   ║')) + bold('   autoskills                        ') + bold(cyan('║')))
  console.log(bold(cyan('   ║')) + dim('   Auto-install the best AI skills   ') + bold(cyan('║')))
  console.log(bold(cyan('   ║')) + dim('   for your project                  ') + bold(cyan('║')))
  console.log(bold(cyan('   ╚═══════════════════════════════════════╝')))
  console.log()
}

/**
 * Interactive multi-select: arrow keys to move, space to toggle, enter to confirm.
 * All items are selected by default. Returns the filtered list of selected items.
 */
function multiSelect(items, { labelFn, hintFn }) {
  if (!process.stdin.isTTY) return Promise.resolve(items)

  return new Promise((resolve) => {
    const selected = new Array(items.length).fill(true)
    let cursor = 0
    const totalLines = items.length + 2

    function render() {
      // Move cursor up to overwrite previous render (except first time)
      process.stdout.write(`\x1b[${totalLines}A`)
      draw()
    }

    function draw() {
      for (let i = 0; i < items.length; i++) {
        const pointer = i === cursor ? cyan('❯') : ' '
        const check = selected[i] ? green('◼') : dim('◻')
        const label = labelFn(items[i], i)
        const hint = hintFn ? hintFn(items[i], i) : ''
        const line = selected[i] ? label : dim(label)
        process.stdout.write(`   ${pointer} ${check} ${line}${hint ? '  ' + dim(hint) : ''}\x1b[K\n`)
      }
      process.stdout.write(`\x1b[K\n`)
      const count = selected.filter(Boolean).length
      process.stdout.write(dim(`   ↑↓ move · space toggle · a toggle all · enter confirm (${count}/${items.length})\x1b[K`))
    }

    // Print initial blank lines that draw() will fill
    process.stdout.write(HIDE_CURSOR)
    for (let i = 0; i < totalLines; i++) process.stdout.write('\n')
    render()

    const { stdin } = process
    stdin.setRawMode(true)
    stdin.resume()
    stdin.setEncoding('utf-8')

    function onData(key) {
      // Ctrl+C
      if (key === '\x03') {
        cleanup()
        process.stdout.write(SHOW_CURSOR + '\n')
        process.exit(0)
      }

      // Enter
      if (key === '\r' || key === '\n') {
        cleanup()
        process.stdout.write(SHOW_CURSOR)
        // Overwrite the hint line
        process.stdout.write(`\r\x1b[K`)
        const result = items.filter((_, i) => selected[i])
        resolve(result)
        return
      }

      // Space — toggle current
      if (key === ' ') {
        selected[cursor] = !selected[cursor]
        render()
        return
      }

      // 'a' — toggle all
      if (key === 'a') {
        const allSelected = selected.every(Boolean)
        selected.fill(!allSelected)
        render()
        return
      }

      // Arrow keys (escape sequences)
      if (key === '\x1b[A' || key === 'k') {
        cursor = (cursor - 1 + items.length) % items.length
        render()
        return
      }
      if (key === '\x1b[B' || key === 'j') {
        cursor = (cursor + 1) % items.length
        render()
        return
      }
    }

    function cleanup() {
      stdin.setRawMode(false)
      stdin.pause()
      stdin.removeListener('data', onData)
    }

    stdin.on('data', onData)
  })
}

// ── Installation ──────────────────────────────────────────────

function installRepo(repo) {
  return new Promise((resolve) => {
    const child = spawn('npx', ['-y', 'skills', 'add', repo, '-y'], {
      stdio: ['pipe', 'pipe', 'pipe'],
    })

    let output = ''
    child.stdout?.on('data', (d) => { output += d.toString() })
    child.stderr?.on('data', (d) => { output += d.toString() })

    child.on('close', (code) => {
      const foundMatch = output.match(/Found (\d+) skills?/)
      const skillCount = foundMatch ? parseInt(foundMatch[1], 10) : 0
      resolve({ success: code === 0, output, skillCount })
    })

    child.on('error', (err) => {
      resolve({ success: false, output: err.message, skillCount: 0 })
    })
  })
}

// ── Main ──────────────────────────────────────────────────────

async function main() {
  const args = process.argv.slice(2)
  const autoYes = args.includes('-y') || args.includes('--yes')
  const dryRun = args.includes('--dry-run')

  if (args.includes('--help') || args.includes('-h')) {
    console.log(`
  ${bold('autoskills')} — Auto-install the best AI skills for your project

  ${bold('Usage:')}
    npx autoskills            Detect & install skills
    npx autoskills ${dim('-y')}        Skip confirmation
    npx autoskills ${dim('--dry-run')} Show what would be installed

  ${bold('Options:')}
    -y, --yes       Skip confirmation prompt
    --dry-run       Show repos without installing
    -h, --help      Show this help message

  ${dim('Powered by https://skills.sh')}
`)
    process.exit(0)
  }

  printBanner()

  const projectDir = resolve('.')

  // ── Detect technologies
  process.stdout.write(dim('   Scanning project...\r'))
  const { detected, isFrontend } = detectTechnologies(projectDir)
  process.stdout.write('\x1b[K')

  if (detected.length === 0) {
    console.log(yellow('   ⚠ No supported technologies detected.'))
    console.log(dim('   Make sure you run this in a project directory.'))
    console.log()
    process.exit(0)
  }

  // ── Show detected technologies
  const withRepos = detected.filter((t) => t.repos.length > 0)
  const withoutRepos = detected.filter((t) => t.repos.length === 0)

  console.log(bold('   Detected technologies:'))
  console.log()

  for (const tech of withRepos) {
    console.log(green(`     ✔ ${tech.name}`))
  }
  for (const tech of withoutRepos) {
    console.log(dim(`     ● ${tech.name}`) + dim(' (no skills yet)'))
  }
  console.log()

  // ── Collect unique repos
  const repos = collectRepos(detected, isFrontend)

  if (repos.length === 0) {
    console.log(yellow('   No skill repos available for your stack yet.'))
    console.log(dim('   Check https://skills.sh for the latest.'))
    console.log()
    process.exit(0)
  }

  const maxRepoLen = Math.max(...repos.map((r) => r.repo.length))

  // ── Dry run: just list and exit
  if (dryRun) {
    console.log(bold(`   Skill repos to install ${dim(`(${repos.length})`)}:`))
    console.log()
    for (let i = 0; i < repos.length; i++) {
      const { repo, sources } = repos[i]
      const pad = ' '.repeat(maxRepoLen - repo.length)
      const num = String(i + 1).padStart(2, ' ')
      console.log(dim(`   ${num}.`) + ` ${cyan(repo)}${pad}  ${dim(`← ${sources.join(', ')}`)}`)
    }
    console.log()
    console.log(dim('   --dry-run: nothing was installed.'))
    console.log()
    process.exit(0)
  }

  // ── Interactive select or auto-yes
  let selectedRepos

  if (autoYes) {
    console.log(bold(`   Skill repos to install ${dim(`(${repos.length})`)}:`))
    console.log()
    for (let i = 0; i < repos.length; i++) {
      const { repo, sources } = repos[i]
      const pad = ' '.repeat(maxRepoLen - repo.length)
      const num = String(i + 1).padStart(2, ' ')
      console.log(dim(`   ${num}.`) + ` ${cyan(repo)}${pad}  ${dim(`← ${sources.join(', ')}`)}`)
    }
    console.log()
    selectedRepos = repos
  } else {
    console.log(bold(`   Select repos to install ${dim(`(${repos.length} found)`)}:`))
    console.log()

    selectedRepos = await multiSelect(repos, {
      labelFn: (r) => r.repo + ' '.repeat(maxRepoLen - r.repo.length),
      hintFn: (r) => `← ${r.sources.join(', ')}`,
    })

    if (selectedRepos.length === 0) {
      console.log()
      console.log(dim('   Nothing selected.'))
      console.log()
      process.exit(0)
    }
  }

  console.log()

  // ── Install repos
  let installed = 0
  let failed = 0
  let totalSkills = 0

  for (const { repo } of selectedRepos) {
    process.stdout.write(dim(`   ◌ ${repo}...`))

    const result = await installRepo(repo)

    process.stdout.write('\r\x1b[K')

    if (result.success) {
      const count = result.skillCount || '?'
      const label = count === 1 ? 'skill' : 'skills'
      console.log(green(`   ✔ ${repo}`) + dim(` (${count} ${label})`))
      installed++
      totalSkills += result.skillCount
    } else {
      console.log(red(`   ✘ ${repo}`) + dim(' — failed'))
      failed++
    }
  }

  // ── Summary
  console.log()
  if (failed === 0) {
    console.log(
      green(bold(`   ✔ Done! ${totalSkills} skills installed from ${installed} repos.`)),
    )
  } else {
    console.log(
      yellow(
        `   Done: ${green(`${installed} repos installed`)}, ${red(`${failed} failed`)}.`,
      ),
    )
  }
  console.log(dim('   Powered by https://skills.sh'))
  console.log()
}

main().catch((err) => {
  console.error(red(`\n   Error: ${err.message}\n`))
  process.exit(1)
})
