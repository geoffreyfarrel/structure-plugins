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
/plugin marketplace add <your-github-username>/structure-plugins
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
      "source": { "source": "github", "repo": "<your-username>/structure-plugins" },
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
