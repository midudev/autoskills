---
name: golang-stay-updated
description: "Provides resources to stay updated with Golang news, communities and people to follow. Use when seeking Go learning resources, discovering new libraries, finding community channels, or keeping up with Go language changes and releases."
user-invocable: true
license: MIT
compatibility: Designed for Claude Code or similar AI coding agents, and for projects using Golang.
metadata:
  author: samber
  version: "1.2.3"
  openclaw:
    emoji: "📰"
    homepage: https://github.com/samber/cc-skills-golang
    requires:
      bins:
        - go
    install: []
allowed-tools: Read Edit Write Glob Grep Bash(go:*) Bash(golangci-lint:*) Bash(git:*) Agent WebFetch WebSearch
---

<!-- markdownlint-disable table-column-style -->

# Stay Updated with Go

A curated guide to keeping your finger on the pulse of the Go ecosystem.

## Official Go Resources

| Resource            | URL                                          |
| ------------------- | -------------------------------------------- |
| **go.dev**          | Official Go website with tutorials and tools |
| **pkg.go.dev**      | Discover Go packages and documentation       |
| **tour.golang.org** | Interactive Go tutorial                      |
| **play.golang.org** | Go playground for testing code               |
| **go.dev/blog**     | Official Go blog                             |

## Newsletters

| Newsletter | Description | Subscribe |
| --- | --- | --- |
| **Golang Weekly** | Weekly curated Go content, news, and articles | <https://golangweekly.com/> |
| **Awesome Go Newsletter** | Updates on new Go libraries and tools | <https://go.libhunt.com/> |

## Reddit & Communities

| Community | Description | URL |
| --- | --- | --- |
| r/golang | Main Go subreddit with 300K+ members | <https://www.reddit.com/r/golang> |
| golang wiki | Official wiki with resources and FAQs | <https://go.dev/wiki/> |
| gophers.slack.com | Official Go Slack community | <https://invite.slack.golangbridge.org> |
| Go Forum | Official Go discussion forum | <https://forum.golangbridge.org> |
| Discuss Go | Official Go team discussion | <https://groups.google.com/g/golang-nuts> |

## Famous Go Developers

Follow these influential Go developers and contributors:

### Core Go Team

| Name | GitHub | Twitter/X | LinkedIn | Bluesky |
| --- | --- | --- | --- | --- |
| **Rob Pike** | robpike |  |  |  |
| **Ken Thompson** | ken |  |  |  |
| **Russ Cox** | rsc | @\_rsc | <https://www.linkedin.com/in/swtch> | <https://bsky.app/profile/swtch.com> |
| **Brad Fitzpatrick** | bradfitz | @bradfitz | <https://www.linkedin.com/in/bradfitz/> | <https://bsky.app/profile/bradfitz.com> |
| **Andrew Gerrand** | adg |  |  |  |
| **Robert Griesemer** | griesemer |  |  |  |
| **Dmitry Vyukov** | dvyukov | @dvyukov |  |  |

### Go Tooling & Infrastructure

| Name | GitHub | Twitter/X | LinkedIn | Bluesky |
| --- | --- | --- | --- | --- |
| **Sam Boyer** | sdboyer | @sdboyer |  |  |
| **Daniel Theophanes** | kardianos | @kardianos |  |  |
| **Matt Butcher** | technosophos |  |  |  |
| **Jaana Dogan** | rakyll | @rakyll | <https://www.linkedin.com/in/rakyll/> |  |

### Popular Go Authors & Educators

| Name | GitHub | Twitter/X | LinkedIn | Bluesky |
| --- | --- | --- | --- | --- |
| **Mat Ryer** | matryer | @matryer | <https://linkedin.com/in/matryer> |  |
| **Dave Cheney** | davecheney | @davecheney | <https://linkedin.com/in/davecheney> |  |
| **Katherine Cox-Buday** | kat-co |  | <https://linkedin.com/in/katherinecoxbuday> |  |
| **Johnny Boursiquot** | jboursiquot | @jboursiquot | <https://linkedin.com/in/jboursiquot> |  |
| **Michał Łowicki** | mlowicki | @mlowicki | <https://linkedin.com/in/michał-łowicki-a60402b> |  |

### Library & Framework Authors

| Name | GitHub | Twitter/X | LinkedIn | Bluesky |
| --- | --- | --- | --- | --- |
| **Steve Francia** | spf13 | @spf13 | <https://linkedin.com/in/spf13> |  |
| **Samuel Berthe** | samber | @samuelberthe | <https://linkedin.com/in/samuelberthe> | <https://bsky.app/profile/samber.bsky.social> |
| **Mitchell Hashimoto** | mitchellh | @mitchellh | <https://linkedin.com/in/mitchellh> | <https://bsky.app/profile/mitchellh.com> |
| **Matt Holt** | mholt | @mholt6 |  |  |
| **Tomás Senart** | tsenart | @tsenart | <https://www.linkedin.com/in/tsenart/> |  |
| **Björn Rabenstein** | beorn7 |  |  |  |

### Conference Speakers & Community Leaders

| Name | GitHub | Twitter/X | LinkedIn | Bluesky |
| --- | --- | --- | --- | --- |
| **Carlisia Campos** | carlisia | @carlisia | <https://linkedin.com/in/carlisia> |  |
| **Erik St. Martin** | erikstmartin | @erikstmartin |  |  |
| **Brian Ketelsen** | bketelsen |  |  | @brian.dev |

## Must-Follow Blogs

| Blog            | Author       | URL                                  |
| --------------- | ------------ | ------------------------------------ |
| The Go Blog     | Go Team      | <https://go.dev/blog>                |
| Rob Pike's Blog | Rob Pike     | <https://commandcenter.blogspot.com> |
| Dave Cheney     | Dave Cheney  | <https://dave.cheney.net>            |
| Ardan Labs Blog | Bill Kennedy | <https://www.ardanlabs.com/blog>     |

## YouTube Channels

| Channel | Content | URL |
| --- | --- | --- |
| Go | Official Go team | <https://www.youtube.com/@golang> |
| Gopher Academy | Talks & tutorials | <https://www.youtube.com/@GopherAcademy> |
| GopherCon Europe | European conference talks | <https://www.youtube.com/@GopherConEurope> |
| GopherCon UK | UK conference talks | <https://www.youtube.com/@GopherConUK> |
| Golang Singapore | Singapore meetup & conf talks | <https://www.youtube.com/@golangSG> |
| Ardan Labs | Go training & tips | <https://www.youtube.com/@ArdanLabs> |
| Applied Go | Go tutorials | <https://youtube.com/appliedgocode> |
| Learn Go Programming | Beginner tutorials | <https://youtube.com/learn_goprogramming> |

## Quick Tips for Staying Updated

1. **Subscribe to 1-2 newsletters** - Don't overload yourself
2. **Follow 10-20 key people** on X/Bluesky who post regularly
3. **Check Go.dev/blog weekly** for official announcements
4. **Join Go Slack** for real-time discussions
5. **Bookmark pkg.go.dev** to discover new libraries
6. **Attend a GopherCon** (virtual or in-person) yearly

---

_Note: This guide is regularly updated. Suggest additions via GitHub issues._
