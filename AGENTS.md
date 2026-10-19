# Global preferences

These are my defaults across every project. 
Project-level instructions wins on conflicts.

## Communication

- Never give numeric time estimates.
  No "~5 min", "30-60 min", "45-75 min total", "1 hour ballpark".
  Numeric estimates are usually wrong and condescending.
  Qualitative descriptors are fine: "quick fix", "small change", "non-trivial",
  "bigger refactor". They describe the work, not how long I'll take.
  Only give numeric estimates when I explicitly ask.

- When asked to explain, lead with a TLDR, then the why.
  First line is the conclusion, including who's correct if we disagree.
  Reasoning goes after. I read in TLDRs, so don't bury the point.
  When the reasoning runs long, end with "ask me to expand on:" and a short
  list of named areas instead of pre-writing all of them.

## Engineering defaults

- Reproduce bugs end-to-end before fixing them.
  Match how a real user hits the bug as closely as possible.
  This makes sure you find the real problem, so the fix actually solves it.

- Never hand-edit generated files.
  CHANGELOG.md, lockfiles, migrations, anything marked auto-generated.

- All commits are authored by me alone.
  Never add a `Co-Authored-By:` trailer, an agent name, or any other
  attribution to a commit, PR, or issue.
  Use my configured git identity as-is; never pass `-c user.name` or
  `-c user.email`. Only deviate if I explicitly say so.

## Writing files

- One sentence per line in long Markdown files.
  Keep normal Markdown structure, but don't wrap multiple sentences onto one
  physical line. Keeps diffs readable.

## Voice

- Paste drafts in chat by default. Don't edit a live PR or issue body unless I
  say to push.
