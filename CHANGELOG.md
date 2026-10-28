# Changelog

## [0.5.2]

- Merge remote-tracking branch 'origin/prod' into prod


## [0.5.1]

- fix: migrate to analyzer-plugin lints, fix CI workflows, format



## [0.5.0]

- chore: standardize README and CI/CD workflows, remove donation links, update contact info and repository links
- chore: resolve analyzer issues

## [0.4.1]

- Released @ 10/2026 (UTC)
- fix: case conversions (`toSnakeCase`, `toKebabCase`, `toDotCase`, `toPathCase`, `toCamelCase`, `toPascalCase`, `toCapitalizedKebabCase` and their upper/lower variants) keep letters, accent marks and digits of every script instead of deleting every non-ASCII character: `café_au_lait` → `café_au_lait` (was `caf_au_lait`), `日本語` → `日本語` (was empty), `überCool` → `über_cool`. Output for ASCII input is byte-identical to 0.4.0 (pinned by a golden table and a fuzz test against the 0.4.0 implementation). Emoji, symbols and punctuation are still delimiters.
- fix: `capitalize`, `withFirstLetterAsUpperCase` and `withFirstLetterAsLowerCase` convert a first letter outside the Basic Multilingual Plane instead of leaving it unchanged.
- fix: `replaceLast` with a `String` pattern replaces the true last occurrence even when it overlaps an earlier one: `'aaa'.replaceLast('aa', 'X')` is `'aX'` (was `'Xa'`). `RegExp` patterns still replace the last non-overlapping match.
- fix: `truncToLength` counts runes and never splits a surrogate pair: `'😀😀'.truncToLength(1)` is `'😀'` (was half an emoji). **Behavioural change:** for text with characters outside the BMP (e.g. emoji), `length` now counts each such character once rather than as two UTF-16 code units. Output for BMP-only text is unchanged.

## [0.4.0]

- Released @ 8/2026 (UTC)
- fix: case conversions (`toSnakeCase`, `toKebabCase`, `toDotCase`, `toCamelCase`, `toPascalCase`, `toPathCase`, and their variants) no longer split at letter↔digit boundaries — digits now stay attached to the letter run they touch, matching the Rails `underscore` convention. `phoneE164` → `phone_e164` (was `phone_e_164`), `line1` → `line1` (was `line_1`), `version1` → `version1` (was `version_1`). A digit immediately before an uppercase letter is still a word boundary (`foo1Bar` → `foo1_bar`), so camel/snake round-trips stay stable. This keeps generated wire keys aligned with database columns that embed digits. **Behavioural change:** consumers that relied on the old digit-splitting output will see different results.

## [0.3.0]

- Released @ 5/2026 (UTC)
- fix: `truncToLength` now appends `ellipsis` only when truncation actually occurs, returns short inputs unchanged, preserves leading whitespace (only trailing whitespace exposed by the cut is trimmed), and throws `RangeError` on negative `length`
- fix: `forceObjToString` is guaranteed not to throw even when both `toString` and `hashCode` misbehave; falls back to `'<unrepresentable object>'` in that case

## [0.2.10]

- Released @ 12/2025 (UTC)
- Add an UNCHANGED StringCaseType

## [0.2.9]

- Released @ 6/2025 (UTC)
- Update dependencies

## [0.2.8]

- Released @ 6/2025 (UTC)
- Update dependencies

## [0.2.7]

- Released @ 6/2025 (UTC)
- Refactor and clean

## [0.2.6]

- Released @ 6/2025 (UTC)
- Update dependencies

## [0.2.5]

- Released @ 6/2025 (UTC)
- Make string type conversions more robust

## [0.2.4]

- Released @ 12/2024 (UTC)
- refactor: Improve code structure

## [0.2.3]

- Released @ 12/2024 (UTC)
- chore: Update CI/CD script

## [0.2.2]

- Released @ 12/2024 (UTC)
- docs: Update readme and comments

## [0.2.1]

- Released @ 12/2024 (UTC)
- chore: Update topics in pubspec.yaml, docs and comments

## [0.2.0]

- Released @ 12/2024 (UTC)
- chore: Update docs and format code

## [0.1.2]

- Released @ 12/2024 (UTC)
- feat: Add extension NullIfEmptyOnStringX

## [0.1.1]

- Released @ 12/2024 (UTC)
- chore: Update workflow scripts

## [0.1.0]

- Released @ 12/2024 (UTC)
- Initial commit
