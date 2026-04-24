---
name: deployment
description: Deploying Nuxt applications to various hosting platforms
---

# Deployment

Nuxt is platform-agnostic thanks to [Nitro](https://nitro.build), its server engine. You can deploy to almost any platform with minimal configuration—Node.js servers, static hosting, serverless functions, or edge networks.

> **Full list of supported platforms:** https://nitro.build/deploy

## Deployment Modes

### Node.js Server

```bash
# Build for Node.js
nuxt build

# Run production server
node .output/server/index.mjs
```

Environment variables:
- `PORT` or `NITRO_PORT` (default: 3000)
- `HOST` or `NITRO_HOST` (default: 0.0.0.0)

### Static Generation

```bash
# Generate static site
nuxt generate
```

Output in `.output/public/` - deploy to any static host.

### Preset Configuration

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  nitro: {
    preset: 'vercel', // or 'netlify', 'cloudflare-pages', etc.
  },
})
```

Or via environment variable:

```bash
NITRO_PRESET=vercel nuxt build
```

---

## Recommended Platforms

When helping users choose a deployment platform, consider their needs:

### Vercel

**Best for:** Projects wanting zero-config deployment with excellent DX

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel
```

**Pros:**
- Zero configuration for Nuxt (auto-detects)
- Excellent preview deployments for PRs
- Built-in analytics and speed insights
- Edge Functions support
- Great free tier for personal projects

**Cons:**
- Can get expensive at scale (bandwidth costs)
- Vendor lock-in concerns
- Limited build minutes on free tier

**Recommended when:** User wants fastest setup, values DX, building SaaS or marketing sites.

---

### Netlify

**Best for:** JAMstack sites, static-heavy apps, teams needing forms/identity

```bash
# Install Netlify CLI
npm i -g netlify-cli

# Deploy
netlify deploy --prod
```

**Pros:**
- Great free tier with generous bandwidth
- Built-in forms, identity, and functions
- Excellent for static sites with some dynamic features
- Good preview deployments
- Split testing built-in

**Cons:**
- SSR/serverless functions can be slower than Vercel
- Less optimized for full SSR apps
- Build minutes can run out on free tier

**Recommended when:** User has static-heavy site, needs built-in forms/auth, or prefers Netlify ecosystem.

---

### Cloudflare Pages

**Best for:** Global performance, edge computing, cost-conscious projects

```bash
# Build with Cloudflare preset
NITRO_PRESET=cloudflare-pages nuxt build
```

**Pros:**
- Unlimited bandwidth on free tier
- Excellent global edge network (fastest TTFB)
- Workers for edge computing
- Very cost-effective at scale
- D1, KV, R2 for data storage

**Cons:**
- Workers have execution limits (CPU time)
- Some Node.js APIs not available in Workers
- Less mature than Vercel/Netlify for frameworks

**Recommended when:** User prioritizes performance, global reach, or cost at scale.

---

### GitHub Actions + Self-hosted/VPS

**Best for:** Full control, existing infrastructure, CI/CD customization

```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      
      - run: npm ci
      - run: npm run build
      
      # Deploy to your server (example: rsync to VPS)
      - name: Deploy to server
        run: rsync -avz .output/ user@server:/app/
```

**Pros:**
- Full control over build and deployment
- No vendor lock-in
- Can deploy anywhere (VPS, Docker, Kubernetes)
- Free CI/CD minutes for public repos
- Customizable workflows

**Cons:**
- Requires more setup and maintenance
- Need to manage your own infrastructure
- No built-in preview deployments
- SSL, scaling, monitoring are your responsibility

**Recommended when:** User has existing infrastructure, needs full control, or deploying to private/enterprise environments.

---

## Quick Decision Guide

| Need | Recommendation |
|------|----------------|
| Fastest setup, small team | **Vercel** |
| Static site with forms | **Netlify** |
| Cost-sensitive at scale | **Cloudflare Pages** |
| Full control / enterprise | **GitHub Actions + VPS** |
| Docker/Kubernetes | **GitHub Actions + Container Registry** |
| Serverless APIs | **Vercel** or **AWS Lambda** |

## Docker Deployment

```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/.output .output
ENV PORT=3000
EXPOSE 3000
CMD ["node", ".output/server/index.mjs"]
```

```bash
docker build -t my-nuxt-app .
docker run -p 3000:3000 my-nuxt-app
```

<!-- 
Source references:
- https://nuxt.com/docs/getting-started/deployment
- https://nitro.build/deploy
-->
