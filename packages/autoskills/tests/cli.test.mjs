import { describe, it, beforeEach, afterEach } from 'node:test'
import assert from 'node:assert/strict'
import { execFileSync } from 'node:child_process'
import { mkdtempSync, writeFileSync, rmSync } from 'node:fs'
import { join, resolve } from 'node:path'
import { tmpdir } from 'node:os'

const CLI_PATH = resolve(import.meta.dirname, '..', 'index.mjs')

function run(args = [], cwd = process.cwd()) {
  return execFileSync(process.execPath, [CLI_PATH, ...args], {
    cwd,
    encoding: 'utf-8',
    timeout: 10_000,
    env: { ...process.env, NO_COLOR: '1' },
  })
}

describe('CLI', () => {
  it('shows help with --help', () => {
    const output = run(['--help'])
    assert.ok(output.includes('autoskills'))
    assert.ok(output.includes('--dry-run'))
    assert.ok(output.includes('--yes'))
    assert.ok(output.includes('skills.sh'))
  })

  it('shows help with -h', () => {
    const output = run(['-h'])
    assert.ok(output.includes('autoskills'))
  })

  describe('--dry-run', () => {
    let tmpDir

    beforeEach(() => {
      tmpDir = mkdtempSync(join(tmpdir(), 'autoskills-cli-'))
    })

    afterEach(() => {
      rmSync(tmpDir, { recursive: true, force: true })
    })

    it('shows detected technologies without installing', () => {
      writeFileSync(
        join(tmpDir, 'package.json'),
        JSON.stringify({
          dependencies: { react: '^19', next: '^15' },
          devDependencies: { typescript: '^5' },
        }),
      )
      writeFileSync(join(tmpDir, 'tsconfig.json'), '{}')

      const output = run(['--dry-run'], tmpDir)

      assert.ok(output.includes('React'))
      assert.ok(output.includes('Next.js'))
      assert.ok(output.includes('TypeScript'))
      assert.ok(output.includes('--dry-run'))
      assert.ok(output.includes('nothing was installed'))
    })

    it('warns when no technologies are detected', () => {
      writeFileSync(join(tmpDir, 'package.json'), JSON.stringify({}))

      const output = run(['--dry-run'], tmpDir)
      assert.ok(output.includes('No supported technologies'))
    })

    it('shows repos grouped by source technology', () => {
      writeFileSync(
        join(tmpDir, 'package.json'),
        JSON.stringify({
          devDependencies: { tailwindcss: '^4', typescript: '^5' },
        }),
      )
      writeFileSync(join(tmpDir, 'tsconfig.json'), '{}')

      const output = run(['--dry-run'], tmpDir)

      assert.ok(output.includes('wshobson/agents'))
      assert.ok(output.includes('Tailwind CSS'))
      assert.ok(output.includes('TypeScript'))
    })

    it('detects technologies from config files only', () => {
      writeFileSync(join(tmpDir, 'package.json'), JSON.stringify({}))
      writeFileSync(join(tmpDir, 'next.config.mjs'), 'export default {}')

      const output = run(['--dry-run'], tmpDir)

      assert.ok(output.includes('Next.js'))
    })
  })
})
