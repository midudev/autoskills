---
name: elevenlabs-tts
description: "ElevenLabs text-to-speech with 22+ premium voices, multilingual support, and voice tuning via inference.sh CLI. Models: eleven_multilingual_v2 (highest quality), eleven_turbo_v2_5 (low latency), eleven_flash_v2_5 (ultra-fast). Capabilities: text-to-speech, voice selection, stability/style control, 32 languages. Use for: voiceovers, audiobooks, video narration, podcasts, accessibility, IVR. Triggers: elevenlabs, eleven labs, elevenlabs tts, premium tts, professional voice, ai voice, high quality tts, multilingual tts, eleven labs voice, voice generation, natural speech, realistic voice, voice over, speech synthesis"
allowed-tools: Bash(belt *)
---

# ElevenLabs Text-to-Speech

Premium text-to-speech with 22+ voices via [inference.sh](https://inference.sh) CLI.

![ElevenLabs TTS](https://cloud.inference.sh/u/4mg21r6ta37mpaz6ktzwtt8krr/01jz00krptarq4bwm89g539aea.png)

## Quick Start

> Requires inference.sh CLI (`belt`). [Install instructions](https://raw.githubusercontent.com/inference-sh/skills/refs/heads/main/cli-install.md)

```bash
belt login

# Generate speech with ElevenLabs
belt app run elevenlabs/tts --input '{"text": "Hello, welcome to our product demo.", "voice": "aria"}'
```


## Available Models

| Model | ID | Best For | Latency |
|-------|----|----------|---------|
| Multilingual v2 | `eleven_multilingual_v2` | Highest quality, 32 languages | ~250ms |
| Turbo v2.5 | `eleven_turbo_v2_5` | Balance of speed & quality | ~150ms |
| Flash v2.5 | `eleven_flash_v2_5` | Ultra-low latency | ~75ms |

## Voice Library

### Female Voices

| Voice | Style |
|-------|-------|
| `aria` | American, conversational |
| `alice` | British, confident |
| `bella` | American, warm |
| `jessica` | American, expressive |
| `laura` | American, professional |
| `lily` | British, soft |
| `sarah` | American, friendly |

### Male Voices

| Voice | Style |
|-------|-------|
| `george` | British, authoritative |
| `adam` | American, deep |
| `bill` | American, mature |
| `brian` | American, conversational |
| `callum` | Transatlantic, intense |
| `charlie` | Australian, natural |
| `chris` | American, casual |
| `daniel` | British, commanding |
| `eric` | American, friendly |
| `harry` | American, young |
| `liam` | American, articulate |
| `matilda` | American, warm |
| `river` | American, confident |
| `roger` | American, authoritative |
| `will` | American, bright |

## Examples

### Basic Speech

```bash
belt app run elevenlabs/tts --input '{"text": "Welcome to our quarterly earnings presentation.", "voice": "george"}'
```

### Choose a Model

```bash
# Highest quality
belt app run elevenlabs/tts --input '{
  "text": "This is our premium multilingual model with the best quality.",
  "voice": "aria",
  "model": "eleven_multilingual_v2"
}'

# Ultra-fast for real-time applications
belt app run elevenlabs/tts --input '{
  "text": "Flash model for low-latency applications.",
  "voice": "brian",
  "model": "eleven_flash_v2_5"
}'
```

### Voice Tuning

```bash
belt app run elevenlabs/tts --input '{
  "text": "Fine-tune the voice characteristics for your use case.",
  "voice": "bella",
  "stability": 0.3,
  "similarity_boost": 0.9,
  "style": 0.4
}'
```

| Parameter | Range | Effect |
|-----------|-------|--------|
| `stability` | 0-1 | Higher = more consistent, lower = more expressive |
| `similarity_boost` | 0-1 | Higher = closer to original voice character |
| `style` | 0-1 | Higher = more style exaggeration |
| `use_speaker_boost` | true/false | Enhances speaker clarity |

### Output Formats

```bash
# High-quality MP3
belt app run elevenlabs/tts --input '{
  "text": "High quality audio output.",
  "voice": "daniel",
  "output_format": "mp3_44100_192"
}'
```

| Format | Description |
|--------|-------------|
| `mp3_44100_128` | MP3 at 44.1kHz, 128kbps (default) |
| `mp3_44100_192` | MP3 at 44.1kHz, 192kbps |
| `pcm_16000` | Raw PCM at 16kHz |
| `pcm_22050` | Raw PCM at 22.05kHz |
| `pcm_24000` | Raw PCM at 24kHz |
| `pcm_44100` | Raw PCM at 44.1kHz |

### Multilingual

ElevenLabs supports 32 languages including English, Spanish, French, German, Italian, Portuguese, Chinese, Japanese, Korean, Arabic, Hindi, Russian, and more.

```bash
# Spanish
belt app run elevenlabs/tts --input '{
  "text": "Hola, bienvenidos a nuestra presentación.",
  "voice": "aria",
  "model": "eleven_multilingual_v2"
}'

# French
belt app run elevenlabs/tts --input '{
  "text": "Bonjour, bienvenue à notre démonstration.",
  "voice": "alice",
  "model": "eleven_multilingual_v2"
}'
```

## Voice + Video Workflow

```bash
# 1. Generate voiceover
belt app run elevenlabs/tts --input '{
  "text": "Introducing the future of AI-powered content creation.",
  "voice": "george"
}' > voiceover.json

# 2. Create talking head video
belt app run bytedance/omnihuman-1-5 --input '{
  "image_url": "https://portrait.jpg",
  "audio_url": "<audio-url-from-step-1>"
}'
```

## Use Cases

- **Voiceovers**: Product demos, explainer videos, commercials
- **Audiobooks**: Long-form narration with consistent voices
- **Podcasts**: AI hosts with natural delivery
- **E-learning**: Course narration in multiple languages
- **Accessibility**: High-quality screen reader content
- **IVR**: Professional phone system messages
- **Video Narration**: Documentary and social media content

## Related Skills

```bash
# ElevenLabs multi-speaker dialogue
npx skills add inference-sh/skills@elevenlabs-dialogue

# ElevenLabs voice changer
npx skills add inference-sh/skills@elevenlabs-voice-changer

# ElevenLabs sound effects
npx skills add inference-sh/skills@elevenlabs-sound-effects

# All TTS models (Kokoro, DIA, Chatterbox, and more)
npx skills add inference-sh/skills@text-to-speech

# Full platform skill (all 250+ apps)
npx skills add inference-sh/skills@infsh-cli
```

Browse all audio apps: `belt app list --category audio`
