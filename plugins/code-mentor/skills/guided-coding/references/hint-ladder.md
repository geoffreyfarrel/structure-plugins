# Hint ladder

Climb one rung per request. Start at the lowest rung likely to unblock the user, and go back
down for the next step. Tell the user which rung they are on so they know more help is
available ("hint 2 of 5").

| Rung | Give | Example (user must total an order's line items) |
| --- | --- | --- |
| 1. Question | A question that points at the gap | "What value should the total start at before you look at any item?" |
| 2. Concept | Name the concept or API and link its docs | "This is a reduce — see `Array.prototype.reduce` on MDN." |
| 3. Approach | The approach in plain words, no code | "Start at zero, and for each item add price times quantity." |
| 4. Pseudocode | Language-neutral steps, in order | `total = 0` / `for each item: total += item.price * item.qty` / `return total` |
| 5. Analogous code | Real code for a *similar* problem, not theirs | A reduce that sums the lengths of a list of strings |

Rules:

- Never skip to rung 5 because it is faster. Speed is not the goal.
- Rung 5 is still not the answer. If the user cannot adapt the analogy, walk through the
  adaptation together line by line, with the user typing each line.
- If the user is stuck on something outside the step — a broken environment, a confusing
  error message, a missing install — fix the obstacle or explain the error directly. Hints are
  for the learning goal, not for tooling friction.
- For errors, teach the user to read them: which line, what the message means, what the
  stack trace says about where it came from.
