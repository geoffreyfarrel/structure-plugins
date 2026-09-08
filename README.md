# Structure Plugins

A Claude Code marketplace of reusable, stack-agnostic development plugins.

## Plugins

| Plugin | Purpose |
| --- | --- |
| [`structure-core`](plugins/structure-core) | Project governance — a four-document contract, ADR gating, verification, commit discipline, and design tokens |

## Install

The marketplace repo is independent of where your projects live. A project on GitLab installs
from this marketplace on GitHub with no friction.

**From GitHub**

```
/plugin marketplace add geoffreyfarrel/structure-plugins
/plugin install structure-core@structure-plugins
```

**From a local path** — for developing and testing before you push:

```
/plugin marketplace add D:\Freelance\structure-plugins
/plugin install structure-core@structure-plugins
```

Enable `autoUpdate` for the marketplace in `~/.claude/settings.json` so every machine picks up
changes without reinstalling:

```json
{
  "extraKnownMarketplaces": {
    "structure-plugins": {
      "source": { "source": "github", "repo": "geoffreyfarrel/structure-plugins" },
      "autoUpdate": true
    }
  }
}
```

## Using it in a repository

```
/st-init      # once per repo — bootstraps the governance documents
/st-status    # any time — reports drift and staleness
```

After `/st-init`, the skills engage on their own. The commands are there for when you want to
drive explicitly.

## Commands vs. skills

The plugin ships two kinds of component, and they show up side by side in Claude Code's
listings — which makes them easy to confuse. They are not alternatives to each other.

| | **Commands** (`/st-*`) | **Skills** |
| --- | --- | --- |
| You | type them | never type them |
| Loading | on demand, when invoked | automatically, when the work matches the description |
| Nature | an **action** — do this now | **knowledge** — the standing rules |
| Count | 8 | 9 |
| Example | `/st-init` | `project-governance` |

A skill is the rulebook; a command is a job that consults it. `project-governance` is the
*standing contract* that says every repo carries four documents and what keeps each one true —
it loads on its own whenever governance is relevant, including when a document is missing.
`/st-init` is the *one-time action* that actually creates those documents, and it reads
`project-governance` to know how.

So there is no `/st-governance` to run. The nearest commands to it are:

- **`/st-init`** — writes the documents. Run once per repo. Detects the stack, interviews you
  only for what the code cannot answer, fills every template placeholder, and verifies the
  command table it recorded actually runs.
- **`/st-status`** — read-only health report on documents that already exist. Run any time.
  Reports drift, staleness, unfilled placeholders, and dangling log threads. Changes nothing.

Rough rule: `/st-init` when the documents are missing, `/st-status` when they exist and you
want to know whether they still tell the truth.

## Components

**Commands** — explicit, typed.

| Command | Does |
| --- | --- |
| `/st-init` | Bootstrap the four documents in a repo |
| `/st-status` | Read-only governance health report |
| `/st-adr` | Draft an ADR, confirm it, then implement |
| `/st-log` | Append this session's outcome to `LOG.md`, compact when due |
| `/st-check` | Run the repo's real format, lint, typecheck, and test commands |
| `/st-commit` | Verify, scan for clutter, commit with a Conventional Commit message |
| `/st-design` | Convert pasted Figma CSS into project tokens |
| `/st-clean` | Inventory one-off scripts and debug leftovers, clean with approval |

**Skills** — automatic, never typed.

| Skill | Engages when |
| --- | --- |
| `project-governance` | Starting work in a repo, or a governance document is missing |
| `branch-workflow` | Before the first edit of a task — big tasks branch automatically, minor ones ask |
| `adr-workflow` | A dependency, schema, architecture, or breaking change is proposed |
| `session-log` | Recovering prior context, or finishing a unit of work |
| `verification-gate` | Before committing, or when asked whether something is done |
| `commit-workflow` | Committing, branching, or opening a PR/MR |
| `design-tokens` | Figma CSS is pasted, or a style value is being changed |
| `engineering-standards` | Any implementation — no hardcoding, scalable structure, no brute force |
| `repo-hygiene` | A throwaway script is being written, or before a commit |

**Hooks** — invisible, always on.

| Event | Behavior |
| --- | --- |
| `SessionStart` | Prints which documents exist and the newest `LOG.md` entry |
| `PreToolUse` (Bash) | Dependency add/remove stops for ADR confirmation; restores pass through |
| `PreToolUse` (Write/Edit) | First edit on the default branch prompts for a branch. Once per session; silent on feature branches |
| `Stop` | Blocks only on skipped verification, a missing ADR, or missing log context |

## Repository layout

```
structure-plugins/
├── .claude-plugin/
│   └── marketplace.json          # marketplace manifest
└── plugins/
    └── structure-core/
        ├── .claude-plugin/
        │   └── plugin.json       # plugin manifest
        ├── commands/             # /st-* slash commands
        ├── skills/               # auto-loading skills, each with SKILL.md
        ├── templates/            # what /st-init copies into a repo
        └── hooks/
            ├── hooks.json
            └── scripts/
```

## Adding a plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json` with at minimum a `name`.
2. Add `commands/`, `skills/`, `agents/`, or `hooks/` at the plugin root — never inside
   `.claude-plugin/`. Discovery is by convention.
3. Register it in the `plugins` array of `.claude-plugin/marketplace.json`.
4. Bump the plugin's `version` on every meaningful change so installs pick it up.

Reference paths inside a plugin with `${CLAUDE_PLUGIN_ROOT}`, never a relative or absolute
path — the plugin is installed into a cache directory whose location you do not control.

## License

MIT
