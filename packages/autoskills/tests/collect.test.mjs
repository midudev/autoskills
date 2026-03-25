import { describe, it } from 'node:test'
import assert from 'node:assert/strict'
import { collectRepos } from '../lib.mjs'

describe('collectRepos', () => {
  it('returns empty array when no technologies detected', () => {
    const repos = collectRepos([], false)
    assert.deepStrictEqual(repos, [])
  })

  it('collects repos from a single technology', () => {
    const detected = [
      { id: 'react', name: 'React', repos: ['vercel-labs/agent-skills'] },
    ]
    const repos = collectRepos(detected, false)

    assert.strictEqual(repos.length, 1)
    assert.strictEqual(repos[0].repo, 'vercel-labs/agent-skills')
    assert.deepStrictEqual(repos[0].sources, ['React'])
  })

  it('deduplicates repos from different technologies', () => {
    const detected = [
      { id: 'tailwind', name: 'Tailwind CSS', repos: ['wshobson/agents'] },
      { id: 'typescript', name: 'TypeScript', repos: ['wshobson/agents'] },
    ]
    const repos = collectRepos(detected, false)

    assert.strictEqual(repos.length, 1)
    assert.strictEqual(repos[0].repo, 'wshobson/agents')
    assert.deepStrictEqual(repos[0].sources, ['Tailwind CSS', 'TypeScript'])
  })

  it('keeps unique repos from different technologies', () => {
    const detected = [
      { id: 'react', name: 'React', repos: ['vercel-labs/agent-skills'] },
      { id: 'nextjs', name: 'Next.js', repos: ['vercel-labs/next-skills'] },
    ]
    const repos = collectRepos(detected, false)

    assert.strictEqual(repos.length, 2)
    assert.strictEqual(repos[0].repo, 'vercel-labs/agent-skills')
    assert.strictEqual(repos[1].repo, 'vercel-labs/next-skills')
  })

  it('handles technologies with multiple repos', () => {
    const detected = [
      { id: 'vue', name: 'Vue', repos: ['hyf0/vue-skills', 'antfu/skills'] },
    ]
    const repos = collectRepos(detected, false)

    assert.strictEqual(repos.length, 2)
    assert.strictEqual(repos[0].repo, 'hyf0/vue-skills')
    assert.strictEqual(repos[1].repo, 'antfu/skills')
  })

  it('adds frontend bonus repos for frontend projects', () => {
    const detected = [
      { id: 'react', name: 'React', repos: ['vercel-labs/agent-skills'] },
    ]
    const repos = collectRepos(detected, true)

    assert.ok(repos.some((r) => r.repo === 'anthropics/skills'))
    const bonus = repos.find((r) => r.repo === 'anthropics/skills')
    assert.deepStrictEqual(bonus.sources, ['Frontend'])
  })

  it('does not add frontend bonus repos for non-frontend projects', () => {
    const detected = [
      { id: 'typescript', name: 'TypeScript', repos: ['wshobson/agents'] },
    ]
    const repos = collectRepos(detected, false)

    assert.ok(!repos.some((r) => r.repo === 'anthropics/skills'))
  })

  it('does not duplicate frontend bonus repos if already present', () => {
    const detected = [
      { id: 'custom', name: 'Custom', repos: ['anthropics/skills'] },
    ]
    const repos = collectRepos(detected, true)

    const matches = repos.filter((r) => r.repo === 'anthropics/skills')
    assert.strictEqual(matches.length, 1)
  })

  it('skips technologies with empty repos', () => {
    const detected = [
      { id: 'svelte', name: 'Svelte', repos: [] },
      { id: 'react', name: 'React', repos: ['vercel-labs/agent-skills'] },
    ]
    const repos = collectRepos(detected, false)

    assert.strictEqual(repos.length, 1)
    assert.strictEqual(repos[0].repo, 'vercel-labs/agent-skills')
  })

  it('accumulates three sources for the same repo', () => {
    const detected = [
      { id: 'a', name: 'Tech A', repos: ['shared/repo'] },
      { id: 'b', name: 'Tech B', repos: ['shared/repo'] },
      { id: 'c', name: 'Tech C', repos: ['shared/repo'] },
    ]
    const repos = collectRepos(detected, false)

    assert.strictEqual(repos.length, 1)
    assert.deepStrictEqual(repos[0].sources, ['Tech A', 'Tech B', 'Tech C'])
  })
})
