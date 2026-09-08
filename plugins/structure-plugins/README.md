# structure-plugins

Stack-agnostic project governance for Claude Code.

The plugin encodes one idea: **a project's durable knowledge belongs in the repository, not in
a session.** Four artifacts carry it, and the plugin keeps them true.

| Artifact | Answers | Kept true by |
| --- | --- | --- |
| `CODINGSTYLE.md` | What stack is this, and how do we write code here? | `project-governance` |
| `DESIGN.md` | What are the typography, color, and spacing rules? | `design-tokens` |
| `LOG.md` | What happened recently, and where was I? | `session-log` |
| `docs/adr/` | Why is it built this way? | `adr-workflow` |

## Commands

| Command | Does |
| --- | --- |
| `/hd-init` | Bootstrap the four artifacts — detects the stack, interviews only for what code cannot answer |
| `/hd-status` | Read-only governance health report: drift, staleness, unfilled placeholders |
| `/hd-adr` | Draft an ADR, confirm it with the user, then implement |
| `/hd-log` | Append this session's durable outcome to `LOG.md`, compact when due |
| `/hd-check` | Run the repo's real format, lint, typecheck, and test commands |
| `/hd-commit` | Verify, scan for clutter, then commit with a Conventional Commit message |
| `/hd-design` | Convert pasted Figma CSS into project tokens, or update `DESIGN.md` |
| `/hd-clean` | Inventory one-off scripts and debug leftovers, clean with approval |

## Skills

Skills load on their own when the work calls for them; the commands are for when you want to
drive explicitly.

- **`project-governance`** — the four-document contract. Detects the stack from lockfiles and
  configs rather than asking; interviews only for genuine preferences.
- **`adr-workflow`** — decides what needs an ADR, and stops *before* implementation to get it
  confirmed. Includes a detailed trigger/non-trigger table.
- **`session-log`** — `LOG.md` as a handoff document, with compaction rules that keep it from
  becoming a wall nobody reads.
- **`verification-gate`** — derives the real command vocabulary (CI first, then manifest
  scripts, then the monorepo orchestrator) and refuses to call unverified work done.
- **`commit-workflow`** — Conventional Commits, plus GitHub PR / GitLab MR detection from the
  git remote.
- **`design-tokens`** — `DESIGN.md` upkeep and Figma→Tailwind conversion, with a strict
  preference order that keeps hardcoded values out.
- **`engineering-standards`** — no hardcoded values, structure that absorbs the next case,
  correct algorithm over brute force. Applied to every implementation without being asked.
- **`repo-hygiene`** — scratch scripts go to the scratchpad, not the repo root.

## Hooks

| Event | Type | Behavior |
| --- | --- | --- |
| `SessionStart` | command | Prints which artifacts exist and the newest `LOG.md` entry. Silent outside a git repo. |
| `PreToolUse` (Bash) | command | Dependency add/remove commands stop for ADR confirmation. Restore commands (`npm install`, `pip install -r`) pass through. |
| `Stop` | prompt | Blocks only when verification was skipped, a dependency/schema/breaking change has no ADR, or durable context is missing from `LOG.md`. Approves by default. |

The Stop hook is deliberately permissive. A false block costs a turn; a false approve costs
almost nothing.

## Design notes

**Stack-agnostic by detection, not by vagueness.** The plugin carries a signal table
(lockfiles, manifests, CI files, framework fingerprints) and derives the concrete commands
for whatever it finds — then writes them into `CODINGSTYLE.md` so they are derived once.

**Detect facts, ask preferences.** Asking which package manager a repo uses, when
`pnpm-lock.yaml` is in the root, destroys trust in the tool. Asking whether existing
conventions are the intended standard or legacy to migrate away from is the single most
valuable question in an existing repo, and no file can answer it.

**Placeholders are worse than gaps.** An unfilled `<!-- TODO -->` in a committed file reads
as a decision that was made. `/hd-init` fills or deletes every one.

## Adapting it

The templates in `templates/` are the parts most worth editing for your own taste — they are
what lands in every repo. The skills are prose; edit them the way you would edit
documentation, and reload with `/plugin`.
