# Bootstrap Interview

Questions to ask when creating `CODINGSTYLE.md` and `DESIGN.md`. Ask only what the repository cannot tell you.

## Rules for asking

- **Batch the questions.** Use one `AskUserQuestion` call with multiple questions, not a serial interrogation.
- **Offer detected values as options.** "Detected Prettier: 4-space, single quotes, 80 cols — adopt as the standard?" beats "What indentation do you want?"
- **Never ask what a file already answers.** Asking the user their package manager when `pnpm-lock.yaml` is sitting in the root destroys trust in the tool.
- **Cap it.** Four questions maximum per round. If more are needed, write the file with the answers you have, mark the rest `<!-- TODO -->`, and resolve them as they come up in real work.

## Greenfield repo — CODINGSTYLE.md

When there is no code yet, everything is a question. Ask these four first; they determine the rest.

1. **Language and runtime** — TypeScript/JavaScript, PHP, Python, Go, other. Include the version.
2. **Framework and architecture shape** — the primary framework, and whether this is a single app, a monorepo, or an API + client pair.
3. **Package manager and test framework** — these two decide the entire command vocabulary.
4. **Strictness posture** — strict types with lint-as-error, or pragmatic with warnings. This one shapes every later judgement call, so do not default it silently.

Then, in a second round if the user is engaged: naming conventions, directory layout, error-handling philosophy, and whether tests are required per change.

## Existing repo — CODINGSTYLE.md

Detect the stack. Ask only about preferences that code cannot reveal, and only the ones that will actually come up:

1. **Are the existing conventions the intended standard, or legacy to migrate away from?** The single most valuable question in an existing repo. Without it you will faithfully replicate patterns the user is trying to kill.
2. **Is a test required for every change?** Detect whether tests exist; ask whether they are mandatory going forward.
3. **Are there directories or patterns that are off-limits** — generated code, vendored code, a legacy module nobody touches?

Record the answer to (1) explicitly in `CODINGSTYLE.md` under a "Migrating away from" heading if there is anything to migrate. That heading is what stops the next session from cementing a dying pattern.

## DESIGN.md — any repo with UI

If the user has a design source, prefer extraction over interrogation:

> "Paste the CSS from a representative Figma frame — ideally a screen with text, a button, and a card. I'll derive the tokens from it."

That single paste answers typography, color, spacing, and radius at once, and grounds them in real values rather than remembered ones. Hand off to the `design-tokens` skill to convert.

If there is no design source, ask:

1. **Is there an existing design system or component library** to conform to (shadcn, Material, Mezzanine, a company system), or is this bespoke?
2. **Light, dark, or both?** This decides whether every token needs a pair.
3. **Base spacing unit and type scale** — offer concrete options (4px grid vs 8px grid; a specific scale) rather than asking abstractly.
4. **Brand colors** — primary, and whether semantic colors (success/warning/danger) are prescribed or your choice.

If the repo has UI code but no `DESIGN.md`, extract the de facto tokens from the code first — the most-used Tailwind classes, the CSS custom properties, the theme block — present them as the detected baseline, and ask whether to codify or revise. Codifying what is already there is usually right; revising is a design project the user should opt into deliberately.

## Skip conditions

Do not run the interview when:

- The repo has no UI at all — skip `DESIGN.md` entirely and note in `CODINGSTYLE.md` that it is intentionally absent.
- The user is mid-task and just wants the immediate thing done. Offer `/st-init` and move on; do not block their request on a questionnaire.
- A parent workspace already defines the standard and this is a child package. Point to the parent instead of forking a second contract.
