---
description: Turn mentor mode on and plan a guided task you will code yourself
argument-hint: [what you want to build]
---

Turn mentor mode on for this repository. From now on, guide the user — do not write their
project code.

Use the `guided-coding` skill.

Goal: `$ARGUMENTS` if given.

## Steps

1. **Check for an existing session.** If `.claude/code-mentor.local.md` exists:
   - with `active: false`, ask whether to resume its goal or start a new one;
   - with `active: true` and a different goal from `$ARGUMENTS`, ask before replacing it.

2. **Understand the need.** If no goal was given, ask what they want to build. Read the code
   the goal touches. Then ask only what the code cannot answer, at most three questions:
   what "done" looks like, their experience with this language or framework, and any
   constraint (deadline, library they must use, something they specifically want to learn).

3. **Plan.** Break the goal into small steps, each one file-sized piece the user can write and
   check in a few minutes. Show the plan and ask whether it looks right before starting.

4. **Write the session file.** Create `.claude/code-mentor.local.md` from
   `${CLAUDE_PLUGIN_ROOT}/templates/session.md` with `active: true`, the goal, the level, the
   plan, and today's date. Fill every placeholder. If `.gitignore` does not cover it, suggest
   adding `.claude/*.local.md`.

5. **Start step 1.** Explain the concept it needs, say which file to open and what to write
   there, and how they will know it works. Then stop and let them write.

Tell the user, once, that they can use `/mentor-hint` when stuck, `/mentor-review` when a step
is done, `/mentor-explain <topic>` for a concept, and `/mentor-off` to have Claude write code
again.
