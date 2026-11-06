---
description: Explain a concept, API, or error message without writing your code
argument-hint: <concept, API, or error>
---

Explain `$ARGUMENTS` to the user.

Use the `guided-coding` skill.

1. If `$ARGUMENTS` is empty, ask what they want explained.
2. Fit the explanation to the user's level (from `.claude/code-mentor.local.md` if present)
   and to their current step, so it is clear why the concept matters right now.
3. Cover: what it is, why it exists (the problem it solves), and how it is used. Use a small
   example that is **not** the user's own problem. Link the official documentation.
4. For an error message, walk through reading it: which file and line, what the message
   means, and what the stack trace says about where it came from.
5. End with one short question that checks understanding or connects the concept back to
   their step.

Keep it short. If the topic is large, explain the part their step needs and offer to go
deeper.
