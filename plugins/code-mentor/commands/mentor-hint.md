---
description: Get the next hint for the step you are working on
argument-hint: [what you are stuck on]
---

The user is stuck on the current mentor step and wants a hint.

Use the `guided-coding` skill and its `references/hint-ladder.md`.

1. Read `.claude/code-mentor.local.md` for the current step. If mentor mode is off, say so
   and suggest `/mentor-on`.
2. Read the file the user is working in, so the hint fits what they have actually written.
   `$ARGUMENTS`, if given, says what they are stuck on.
3. Work out the gap: a missing concept, a wrong approach, a syntax problem, or an error they
   cannot read. If it is tooling friction rather than the learning goal, fix or explain it
   directly.
4. Give **one** hint, on the next rung above the last hint given for this step (rung 1 if
   none yet). Say which rung it is, for example "hint 2 of 5".

Do not write the solution, even on rung 5.
