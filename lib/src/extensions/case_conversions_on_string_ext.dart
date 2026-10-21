//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Copyright © dev-cetera.com & contributors.
//
// The use of this source code is governed by an MIT-style license described in
// the LICENSE file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension CaseConversionsOnStringExt on String {
  /// Converts the string to UPPER_SNAKE_CASE.
  /// Example: 'helloWorld' -> 'HELLO_WORLD'
  String toUpperSnakeCase() => toSnakeCase().toUpperCase();

  /// Converts the string to lower_snake_case (alias for [toSnakeCase]).
  /// Example: 'HelloWorld' -> 'hello_world'
  String toLowerSnakeCase() => toSnakeCase();

  /// Converts the string to snake_case.
  String toSnakeCase() => _extractComponents().join('_');

  /// Converts the string to UPPER-KEBAB-CASE.
  /// Example: 'helloWorld' -> 'HELLO-WORLD'
  String toUpperKebabCase() => toKebabCase().toUpperCase();

  /// Converts the string to lower-kebab-case (alias for [toKebabCase]).
  /// Example: 'HelloWorld' -> 'hello-world'
  String toLowerKebabCase() => toKebabCase();

  /// Converts the string to kebab-case.
  String toKebabCase() => _extractComponents().join('-');

  /// Converts the string to Capitalized-Kebab-Case.
  /// Example: 'helloWorld' -> 'Hello-World'
  String toCapitalizedKebabCase() =>
      _extractComponents().map((e) => e.capitalize()).join('-');

  /// Converts the string to dot.case.
  String toDotCase() => _extractComponents().join('.');

  /// Converts the string to lower.dot.case (alias for [toDotCase]).
  /// Example: 'HelloWorld' -> 'hello.world'
  String toLowerDotCase() => toDotCase();

  /// Converts the string to UPPER.DOT.CASE.
  /// Example: 'HelloWorld' -> 'HELLO.WORLD'
  String toUpperDotCase() => toDotCase().toUpperCase();

  /// Converts the string to path/case.
  /// Example: 'helloWorld' -> 'hello/world'
  String toPathCase([String separator = '/']) =>
      _extractComponents().join(separator);

  /// Converts the string to camelCase.
  /// Example: 'Hello World' -> 'helloWorld'
  String toCamelCase() => toPascalCase().withFirstLetterAsLowerCase();

  /// Converts the string to PascalCase.
  /// Example: 'hello world' -> 'HelloWorld'
  String toPascalCase() =>
      _extractComponents().map((e) => e.capitalize()).join();

  /// Robustly extracts word components from a string and returns them in
  /// lowercase.
  ///
  /// Components split on delimiters (`_`, `-`, `.`, spaces, and any other run
  /// of non-alphanumeric characters) and on camelCase / PascalCase boundaries.
  /// Digits stay attached to the letter run they touch rather than becoming
  /// their own component: `phoneE164` -> `[phone, e164]`, `line1` -> `[line1]`,
  /// `version1` -> `[version1]` — never `[phone, e, 164]` / `[line, 1]`. A
  /// digit followed by an uppercase letter is still a word boundary, so
  /// `foo1Bar` -> `[foo1, bar]` and camel/snake round-trips stay stable.
  ///
  /// This mirrors the Rails `underscore` convention and keeps generated wire
  /// keys aligned with database column names that embed digits (e.g.
  /// `phone_e164`, `line1`, `sha256`, `oauth2`).
  ///
  /// Letters, combining marks and digits of every script are kept
  /// (`café_au_lait` -> `[café, au, lait]`, `日本語` -> `[日本語]`), and
  /// upper/lower case boundaries split in any script that has case
  /// (`überCool` -> `[über, cool]`). Everything else (punctuation, symbols,
  /// emoji, whitespace) is a delimiter. On ASCII input the result is exactly
  /// what the earlier ASCII-only implementation produced.
  List<String> _extractComponents() {
    if (trim().isEmpty) return []; // Return empty list for empty input
    return trim()
        // 1. Add a space before an uppercase letter that follows a lowercase
        //    letter or a digit (and any accent marks on it).
        //    (e.g., 'HelloWorld' -> 'Hello World', 'foo1Bar' -> 'foo1 Bar')
        .replaceAllMapped(
          RegExp(r'([\p{Ll}\p{N}]\p{M}*)(\p{Lu})', unicode: true),
          (m) => '${m[1]} ${m[2]}',
        )
        // 2. Add a space before an uppercase letter that is followed by a
        //    lowercase letter, effectively splitting acronyms.
        //    (e.g., 'HTTPRequest' -> 'HTTP Request')
        .replaceAllMapped(
          RegExp(r'(\p{Lu}\p{M}*)(\p{Lu}\p{M}*\p{Ll})', unicode: true),
          (m) => '${m[1]} ${m[2]}',
        )
        // 3. Replace any run of characters that are not letters, accent
        //    marks or digits with a space.
        //    (e.g., 'hello_world-123' -> 'hello world 123')
        .replaceAll(RegExp(r'[^\p{L}\p{M}\p{N}]+', unicode: true), ' ')
        // 4. Split by spaces and filter out any empty strings.
        .split(' ')
        .where((s) => s.isNotEmpty)
        // 5. Convert all components to lowercase.
        .map((s) => s.toLowerCase())
        .toList();
  }

  /// Returns `true` if the string is identical to its uppercase form.
  ///
  /// Note that strings without any cased letters (empty, digit-only,
  /// punctuation-only, etc.) trivially equal their uppercase form and
  /// therefore also return `true`.
  bool get isUpperCase => this == toUpperCase();

  /// Returns `true` if the string is identical to its lowercase form.
  ///
  /// Note that strings without any cased letters (empty, digit-only,
  /// punctuation-only, etc.) trivially equal their lowercase form and
  /// therefore also return `true`.
  bool get isLowerCase => this == toLowerCase();

  /// Capitalizes the first letter of the string.
  ///
  /// The same as [withFirstLetterAsUpperCase].
  String capitalize() => withFirstLetterAsUpperCase();

  /// Converts the first letter of the string to uppercase.
  ///
  /// The first character is taken as a whole rune, so letters outside the
  /// Basic Multilingual Plane (stored as two UTF-16 code units) are converted
  /// too.
  ///
  /// The same as [capitalize].
  String withFirstLetterAsUpperCase() {
    if (isEmpty) return this;
    final first = _firstRune();
    return first.toUpperCase() + substring(first.length);
  }

  /// Converts the first letter of the string to lowercase.
  ///
  /// The first character is taken as a whole rune, like
  /// [withFirstLetterAsUpperCase].
  String withFirstLetterAsLowerCase() {
    if (isEmpty) return this;
    final first = _firstRune();
    return first.toLowerCase() + substring(first.length);
  }

  /// The first character of this non-empty string as a whole rune (one or
  /// two UTF-16 code units).
  String _firstRune() => String.fromCharCode(runes.first);

  /// Capitalizes each word in the string, assuming words are separated by spaces, hyphens, or underscores.
  String withCapitalizedWords() {
    if (trim().isEmpty) return '';
    // FIX: Added '_' to the regex to correctly handle snake_case inputs.
    return trim()
        .split(RegExp(r'[\s-_]+'))
        .where((e) => e.isNotEmpty)
        .map((e) => e.toLowerCase().capitalize())
        .join(' ');
  }
}
