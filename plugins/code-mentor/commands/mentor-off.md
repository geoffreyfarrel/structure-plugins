---
description: Turn mentor mode off so Claude writes code normally again
argument-hint: [--reset]
---

Turn mentor mode off for this repository.

1. If `.claude/code-mentor.local.md` does not exist, say mentor mode was not on and stop.

2. With `--reset` in `$ARGUMENTS`, delete the session file. Otherwise set `active: false` in
   its frontmatter and leave the plan in place so `/mentor-on` can resume it later.

3. Give a two- or three-line summary: steps finished out of the total, and the concepts
   recorded under **Notes**.

From this point Claude writes code normally. The `guided-coding` rules no longer apply.
