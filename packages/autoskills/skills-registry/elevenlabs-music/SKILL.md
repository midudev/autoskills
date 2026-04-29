---
name: elevenlabs-music
description: "ElevenLabs AI music generation - create original music from text prompts via inference.sh CLI. Capabilities: text-to-music, custom duration up to 10 minutes, genre/mood/instrument control, royalty-free commercial use. Use for: background music, soundtracks, jingles, podcasts, video scores, game audio. Triggers: elevenlabs music, eleven labs music, ai music, generate music, music generation, compose music, ai composer, create song, soundtrack, background music, jingle, elevenlabs compose, music ai"
allowed-tools: Bash(belt *)
---

# ElevenLabs Music Generation

Generate original music from text prompts via [inference.sh](https://inference.sh) CLI.

![Music Generation](https://cloud.inference.sh/u/4mg21r6ta37mpaz6ktzwtt8krr/01jz01qvx0gdcyvhvhpfjjb6s4.png)

## Quick Start

> Requires inference.sh CLI (`belt`). [Install instructions](https://raw.githubusercontent.com/inference-sh/skills/refs/heads/main/cli-install.md)

```bash
belt login

# Generate music
belt app run elevenlabs/music --input '{"prompt": "Upbeat electronic dance track with driving synths"}'
```


## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `prompt` | string | required | Description of desired music (max 2000 chars) |
| `duration_seconds` | number | 30 | Duration in seconds (5-600, max 10 minutes) |

## Examples

### Background Music

```bash
# Lo-fi study beats
belt app run elevenlabs/music --input '{
  "prompt": "Lo-fi hip hop beat, chill study music, vinyl crackle, mellow piano",
  "duration_seconds": 120
}'

# Corporate background
belt app run elevenlabs/music --input '{
  "prompt": "Light corporate background music, positive, motivational, clean",
  "duration_seconds": 60
}'
```

### Cinematic Scores

```bash
# Epic trailer
belt app run elevenlabs/music --input '{
  "prompt": "Epic cinematic orchestral score, dramatic build-up, brass and strings, trailer music",
  "duration_seconds": 45
}'

# Suspense
belt app run elevenlabs/music --input '{
  "prompt": "Dark suspenseful score, tension building, minimal piano, horror atmosphere",
  "duration_seconds": 60
}'
```

### Genre-Specific

```bash
# Jazz
belt app run elevenlabs/music --input '{
  "prompt": "Smooth jazz quartet, saxophone lead, walking bass, brushed drums",
  "duration_seconds": 90
}'

# Electronic
belt app run elevenlabs/music --input '{
  "prompt": "Techno beat, 128 BPM, driving bass, atmospheric synths, club music",
  "duration_seconds": 120
}'

# Acoustic
belt app run elevenlabs/music --input '{
  "prompt": "Acoustic guitar folk song, fingerpicking, warm and intimate",
  "duration_seconds": 60
}'
```

### Short-Form Content

```bash
# Podcast intro (10 seconds)
belt app run elevenlabs/music --input '{
  "prompt": "Podcast intro jingle, professional, tech-themed, catchy",
  "duration_seconds": 10
}'

# Social media clip
belt app run elevenlabs/music --input '{
  "prompt": "Trendy upbeat pop, social media vibe, energetic, youthful",
  "duration_seconds": 15
}'

# Notification sound
belt app run elevenlabs/music --input '{
  "prompt": "Short positive notification melody, clean, satisfying",
  "duration_seconds": 5
}'
```

### Game Audio

```bash
# Battle theme
belt app run elevenlabs/music --input '{
  "prompt": "Intense battle music, fast tempo, orchestral with electric guitar, boss fight",
  "duration_seconds": 120
}'

# Exploration theme
belt app run elevenlabs/music --input '{
  "prompt": "Peaceful exploration music, fantasy RPG, harp and flute, magical atmosphere",
  "duration_seconds": 180
}'

# Menu music
belt app run elevenlabs/music --input '{
  "prompt": "Ambient menu screen music, sci-fi, ethereal synths, space theme",
  "duration_seconds": 60
}'
```

## Prompt Tips

**Genre**: pop, rock, electronic, jazz, classical, hip-hop, lo-fi, ambient, orchestral, folk, R&B, metal, country

**Mood**: happy, sad, energetic, calm, dramatic, epic, mysterious, uplifting, dark, romantic, tense

**Instruments**: piano, guitar, synth, drums, bass, strings, brass, choir, saxophone, violin, flute, harp

**Tempo**: slow, moderate, fast, 80 BPM, 120 BPM, 140 BPM

**Style**: cinematic, minimal, layered, atmospheric, rhythmic, melodic, ambient

## Workflow: Music + Voiceover

```bash
# 1. Generate background music
belt app run elevenlabs/music --input '{
  "prompt": "Soft ambient background music for narration, non-intrusive",
  "duration_seconds": 60
}' > music.json

# 2. Generate voiceover
belt app run elevenlabs/tts --input '{
  "text": "Welcome to our product tour. Let me show you what we have built.",
  "voice": "george"
}' > voice.json

# 3. Merge together
belt app run infsh/media-merger --input '{
  "media": ["<music-url>", "<voice-url>"]
}'
```

## Use Cases

- **Video Production**: Background scores, transitions
- **Podcasts**: Intro/outro, segment breaks
- **Games**: Soundtracks, menu music, battle themes
- **Ads**: Jingles, commercial backgrounds
- **Social Media**: Trending audio for short-form content
- **Presentations**: Professional background music
- **Film**: Scoring, mood setting

## Related Skills

```bash
# ElevenLabs sound effects (combine with music)
npx skills add inference-sh/skills@elevenlabs-sound-effects

# ElevenLabs TTS (add voice over music)
npx skills add inference-sh/skills@elevenlabs-tts

# Other music models (Diffrythm, Tencent)
npx skills add inference-sh/skills@ai-music-generation

# Full platform skill (all 250+ apps)
npx skills add inference-sh/skills@infsh-cli
```

Browse all audio apps: `belt app list --category audio`
