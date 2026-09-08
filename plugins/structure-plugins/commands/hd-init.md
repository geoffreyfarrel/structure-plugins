---
description: Bootstrap HelloDev governance docs in this repository
argument-hint: [--force]
---

Set up the HelloDev four-document contract in this repository.

Use the `project-governance` skill. Follow it exactly — in particular the rule that decides
whether to detect or to ask.

## Steps

1. **Survey.** Check which of these already exist at the repo root:
   `CODINGSTYLE.md`, `DESIGN.md`, `LOG.md`, `docs/adr/`.
   Never overwrite an existing file unless `$ARGUMENTS` contains `--force` and the user
   confirms which specific files to replace.

2. **Detect the stack.** Read manifests, lockfiles, config files, CI workflows, and the git
   remote. Read two or three representative source files to confirm the configs are actually
   followed. Do not ask about anything a file already states.

3. **Interview.** Batch the questions into a single `AskUserQuestion` call, offering the
   detected values as options. Ask only what the repo cannot answer:
   - Are the existing conventions the intended standard, or legacy to migrate away from?
   - Is a test required for every change?
   - Any off-limits paths?
   - For UI repos with no design source: design system, color modes, spacing scale, brand colors.

   If the repo has UI and the user has Figma, ask them to paste the CSS of a representative
   frame instead of answering token questions abstractly.

   Skip the interview for a file that already exists and is being kept.

4. **Write the files.** Copy from `${CLAUDE_PLUGIN_ROOT}/templates/` and fill every
   `<!-- TODO -->` marker with detected or answered content. An unfilled placeholder must not
   survive into a committed file — delete a section that genuinely does not apply rather than
   leaving it blank.

   - `CODINGSTYLE.md` — stack table, verified command table, conventions, non-negotiables
   - `DESIGN.md` — only if the repo has UI; say so explicitly if you skip it
   - `LOG.md` — with a first entry recording this bootstrap
   - `docs/adr/README.md` and `docs/adr/0000-template.md`

   Place `docs/adr/` inside an existing docs tree if the repo already has one.

5. **Verify the command table.** Actually run the format, lint, and typecheck commands you
   recorded. A command table that has never been executed is a guess. Correct any that fail.

6. **Wire up CLAUDE.md.** If it exists, add pointers to the four artifacts and migrate any
   conventions that are inline there into `CODINGSTYLE.md` — confirming before removing
   anything. If it does not exist, offer to create a minimal one that points at the artifacts.

7. **Report.** List what was created, what was skipped and why, and any question left
   unresolved as a `<!-- TODO -->` for later.

Do not commit. Leave the files staged-or-not as the user prefers and tell them what to review.
