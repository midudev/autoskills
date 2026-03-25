import { describe, it, beforeEach, afterEach } from 'node:test'
import assert from 'node:assert/strict'
import { mkdtempSync, writeFileSync, mkdirSync, rmSync } from 'node:fs'
import { join } from 'node:path'
import { tmpdir } from 'node:os'
import {
  getAllPackageNames,
  readPackageJson,
  detectTechnologies,
} from '../lib.mjs'

// ── getAllPackageNames ─────────────────────────────────────────

describe('getAllPackageNames', () => {
  it('returns empty array for null input', () => {
    assert.deepStrictEqual(getAllPackageNames(null), [])
  })

  it('returns empty array for empty package.json', () => {
    assert.deepStrictEqual(getAllPackageNames({}), [])
  })

  it('extracts dependencies', () => {
    const pkg = { dependencies: { react: '^19.0.0', next: '^15.0.0' } }
    assert.deepStrictEqual(getAllPackageNames(pkg), ['react', 'next'])
  })

  it('extracts devDependencies', () => {
    const pkg = { devDependencies: { typescript: '^5.0.0' } }
    assert.deepStrictEqual(getAllPackageNames(pkg), ['typescript'])
  })

  it('merges both dependencies and devDependencies', () => {
    const pkg = {
      dependencies: { react: '^19.0.0' },
      devDependencies: { typescript: '^5.0.0' },
    }
    const result = getAllPackageNames(pkg)
    assert.ok(result.includes('react'))
    assert.ok(result.includes('typescript'))
    assert.strictEqual(result.length, 2)
  })
})

// ── readPackageJson ───────────────────────────────────────────

describe('readPackageJson', () => {
  let tmpDir

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), 'autoskills-test-'))
  })

  afterEach(() => {
    rmSync(tmpDir, { recursive: true, force: true })
  })

  it('returns null when no package.json exists', () => {
    assert.strictEqual(readPackageJson(tmpDir), null)
  })

  it('parses valid package.json', () => {
    const pkg = { name: 'test', dependencies: { react: '^19.0.0' } }
    writeFileSync(join(tmpDir, 'package.json'), JSON.stringify(pkg))
    assert.deepStrictEqual(readPackageJson(tmpDir), pkg)
  })

  it('returns null for invalid JSON', () => {
    writeFileSync(join(tmpDir, 'package.json'), '{ not valid json }}}')
    assert.strictEqual(readPackageJson(tmpDir), null)
  })
})

// ── detectTechnologies ────────────────────────────────────────

describe('detectTechnologies', () => {
  let tmpDir

  beforeEach(() => {
    tmpDir = mkdtempSync(join(tmpdir(), 'autoskills-test-'))
  })

  afterEach(() => {
    rmSync(tmpDir, { recursive: true, force: true })
  })

  it('returns empty when no package.json or config files', () => {
    const { detected } = detectTechnologies(tmpDir)
    assert.strictEqual(detected.length, 0)
  })

  it('detects React from dependencies', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { react: '^19.0.0', 'react-dom': '^19.0.0' } }),
    )
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('react'))
  })

  it('detects Next.js from dependencies', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { next: '^15.0.0' } }),
    )
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('nextjs'))
  })

  it('detects Next.js from config file even without package', () => {
    writeFileSync(join(tmpDir, 'package.json'), JSON.stringify({}))
    writeFileSync(join(tmpDir, 'next.config.mjs'), 'export default {}')
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('nextjs'))
  })

  it('detects Vue from dependencies', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { vue: '^3.0.0' } }),
    )
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('vue'))
  })

  it('detects TypeScript from tsconfig.json', () => {
    writeFileSync(join(tmpDir, 'package.json'), JSON.stringify({}))
    writeFileSync(join(tmpDir, 'tsconfig.json'), '{}')
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('typescript'))
  })

  it('detects Azure from scoped package pattern', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { '@azure/storage-blob': '^12.0.0' } }),
    )
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('azure'))
  })

  it('detects AWS from scoped package pattern', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { '@aws-sdk/client-s3': '^3.0.0' } }),
    )
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('aws'))
  })

  it('detects Tailwind from devDependencies', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ devDependencies: { tailwindcss: '^4.0.0' } }),
    )
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('tailwind'))
  })

  it('detects Tailwind from @tailwindcss/vite', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { '@tailwindcss/vite': '^4.0.0' } }),
    )
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('tailwind'))
  })

  it('detects shadcn/ui from components.json', () => {
    writeFileSync(join(tmpDir, 'package.json'), JSON.stringify({}))
    writeFileSync(join(tmpDir, 'components.json'), '{}')
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('shadcn'))
  })

  it('detects Cloudflare from wrangler.toml', () => {
    writeFileSync(join(tmpDir, 'package.json'), JSON.stringify({}))
    writeFileSync(join(tmpDir, 'wrangler.toml'), '')
    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)
    assert.ok(ids.includes('cloudflare'))
  })

  it('detects multiple technologies at once', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({
        dependencies: { next: '^15', react: '^19', 'react-dom': '^19' },
        devDependencies: { typescript: '^5', '@playwright/test': '^1.40' },
      }),
    )
    writeFileSync(join(tmpDir, 'tsconfig.json'), '{}')

    const { detected } = detectTechnologies(tmpDir)
    const ids = detected.map((t) => t.id)

    assert.ok(ids.includes('react'))
    assert.ok(ids.includes('nextjs'))
    assert.ok(ids.includes('typescript'))
    assert.ok(ids.includes('playwright'))
  })

  it('marks frontend projects correctly', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { react: '^19.0.0' } }),
    )
    const { isFrontend } = detectTechnologies(tmpDir)
    assert.strictEqual(isFrontend, true)
  })

  it('marks non-frontend projects correctly', () => {
    writeFileSync(
      join(tmpDir, 'package.json'),
      JSON.stringify({ dependencies: { express: '^4.0.0' } }),
    )
    const { isFrontend } = detectTechnologies(tmpDir)
    assert.strictEqual(isFrontend, false)
  })
})
