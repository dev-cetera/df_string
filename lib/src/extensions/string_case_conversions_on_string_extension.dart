//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See LICENSE file
// in root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension StringCaseConversionsOnStringExtension on String {
  /// Converts the string to UPPER_SNAKE_CASE;
  String toUpperSnakeCase() => toSnakeCase().toUpperCase();

  /// Converts the string to lower_snake_case (alias for [toSnakeCase]).
  String toLowerSnakeCase() => toSnakeCase();

  /// Converts the string to snake_case.
  String toSnakeCase() {
    final noUpperCase = isUpperCase ? toLowerCase() : this;
    return noUpperCase._extractLowercaseComponents().join('_');
  }

  /// Converts the string to lower-kebab-case.
  String toUpperKebabCase() => toKebabCase().toUpperCase();

  /// Converts the string to lower-kebab-case (alias for [toKebabCase]).
  String toLowerKebabCase() => toKebabCase();

  /// Converts the string to kebab-case.
  String toKebabCase() => _extractLowercaseComponents().join('-');

  /// Converts the string to dot.case.
  String toDotCase() => _extractLowercaseComponents().join('.');

  /// Converts the string to lower.dot.case. (alias for [toDotCase]).
  String toLowerDotCase() => toDotCase();

  /// Converts the string to UPPER.DOT.CASE.
  String toUpperDotCase() => toDotCase().toUpperCase();

  /// Converts the string to path/case.
  String toPathCase([String separator = '/']) =>
      _extractLowercaseComponents().join(separator);

  /// Converts the string to camelCase.
  String toCamelCase() => toPascalCase().withFirstLetterAsLowerCase();

  /// Converts the string to PascalCase.
  String toPascalCase() =>
      _extractLowercaseComponents().map((e) => e.capitalize()).join();

  /// Extracts and returns a list of lowercase components from the string.
  ///
  /// This method identifies components based on transitions between lowercase
  /// and uppercase letters, between letters and digits, within sequences of
  /// uppercase letters (including [special] characters), and at any
  /// non-alphanumeric characters. Each identified component is converted to
  /// lowercase.
  ///
  /// The method is useful for parsing strings formatted in camelCase, PascalCase,
  /// snake_case, kebab-case, or other mixed-case styles into a list of lowercase words or segments.
  ///
  /// Example:
  /// ```dart
  /// var example = 'HelloWorld123.456';
  /// var components = example.extractLowercaseComponents(special = const {'.'});
  /// print(components); // Output: ['hello', 'world', '123+456']
  /// ```
  List<String> _extractLowercaseComponents({
    Set<String> special = const {'.'},
  }) {
    if (isEmpty) return [this];
    final words = <String>[];
    var currentWord = StringBuffer();
    String? a;
    for (var n = 0; n < length; n++) {
      final b = this[n];
      final bIsLetter = b._isLetter || special.contains(b);
      if (bIsLetter || b._isDigit) {
        if (a != null) {
          final aIsLetter = a._isLetter || special.contains(a);
          if ((a.isLowerCase && b.isUpperCase) ||
              (a._isDigit && bIsLetter) ||
              (aIsLetter && b._isDigit) ||
              (a.isUpperCase &&
                  b.isUpperCase &&
                  (n + 1 < length && this[n + 1].isLowerCase))) {
            words.add(currentWord.toString().toLowerCase());
            currentWord = StringBuffer();
          }
        }
        currentWord.write(b);
      } else if (currentWord.isNotEmpty) {
        words.add(currentWord.toString().toLowerCase());
        currentWord = StringBuffer();
      }
      a = b;
    }
    if (currentWord.isNotEmpty) {
      words.add(currentWord.toString().toLowerCase());
    }
    return words;
  }

  /// Returns `true` if the string is a digit.
  bool get _isDigit => RegExp(r'^[0-9]$').hasMatch(this);

  /// Returns `true` if the string is a letter.
  bool get _isLetter => RegExp(r'^[a-zA-Z]$').hasMatch(this);

  /// Returns `true` if the string is all uppercase.
  bool get isUpperCase => this == toUpperCase();

  /// Returns `true` if the string is all lowercase.
  bool get isLowerCase => this == toLowerCase();

  /// Capitalizes the first letter of the string.
  ///
  /// The same as [withFirstLetterAsUpperCase].
  String capitalize() => withFirstLetterAsUpperCase();

  /// Converts the first letter of the string to uppercase.
  ///
  /// The same as [capitalize].
  String withFirstLetterAsUpperCase() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return this[0].toUpperCase() + substring(1);
  }

  /// Converts the first letter of the string to lowercase.
  String withFirstLetterAsLowerCase() {
    if (isEmpty) return this;
    if (length == 1) return toLowerCase();
    return this[0].toLowerCase() + substring(1);
  }

  /// Capitalizes each word in the string.
  String withCapitalizedWords() {
    return trim()
        .split(RegExp(r'[- ]+'))
        .map((e) => e.trim().toLowerCase().capitalize())
        .join(' ');
  }
}
