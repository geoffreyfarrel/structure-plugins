---
description: Review the code you wrote for the current step
argument-hint: [paths]
---

The user says they finished a step and wants it reviewed.

Use the `guided-coding` skill.

Scope: `$ARGUMENTS` if paths are given, otherwise the files changed in the working tree
(`git status --porcelain` and `git diff`), focused on the current step in
`.claude/code-mentor.local.md`.

1. **Read the code they wrote.** Run it, or its tests, if that is possible and safe.
2. **Feedback in this order**, stopping at the first level with real problems:
   1. Does it work for the step's check?
   2. Is it correct for edge cases (empty input, null, errors, boundaries)?
   3. Is it readable and idiomatic for this language?
   4. Does it follow the repo's conventions (`CODINGSTYLE.md` or `CLAUDE.md` if present)?
3. **For each problem**, point to the file and line, describe what the code does, and ask a
   question that leads to the fix. Do not write the corrected code.
4. **If the step passes**, name one specific thing done well, tick the step and advance
   `current_step` in the session file, and introduce the next step. If it was the last step,
   congratulate them, summarise what they built and learned, and suggest `/mentor-off` or a
   new goal.
