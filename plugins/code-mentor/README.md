# code-mentor

Turns Claude into a coding guide. While mentor mode is on, you write every line of code;
Claude plans the work in small steps, explains the concepts, gives hints when you are stuck,
and reviews what you wrote before moving on.

## Install

```
/plugin marketplace add geoffreyfarrel/structure-plugins
/plugin install code-mentor@structure-plugins
```

## Use

```
/mentor-on build a login form with email validation
```

Claude reads the relevant code, asks a few questions (what "done" means, your experience),
proposes a step-by-step plan, and starts you on step 1. Then:

| Command | Does |
| --- | --- |
| `/mentor-on [goal]` | Turn mentor mode on and plan a task, or resume a paused one |
| `/mentor-hint [what's wrong]` | Next hint for the current step — escalates from a question to pseudocode |
| `/mentor-review [paths]` | Review what you wrote; advances to the next step when it passes |
| `/mentor-explain <topic>` | Explain a concept, API, or error message |
| `/mentor-off [--reset]` | Back to normal Claude. Keeps the plan unless `--reset` |

You do not have to use the commands — asking "I'm stuck" or "done, check it" works too.

## How it works

| Component | Role |
| --- | --- |
| `guided-coding` skill | The rules: no writing your code, the step loop, tone, review order |
| Hint ladder | Five rungs: question → concept and docs → approach → pseudocode → code for a similar problem |
| Session file | `.claude/code-mentor.local.md` holds the goal, plan, current step, and notes. Survives restarts |
| Hooks | On session start and every prompt, a one-line reminder while mentor mode is on. Silent when off |

The no-code rule is **soft**: nothing blocks Claude from editing files. If you ask Claude to
just write it, it will point out mentor mode is on and offer a bigger hint or `/mentor-off`;
if you insist, it writes the code and explains it line by line.

Add `.claude/*.local.md` to your `.gitignore` so the session file is not committed.
