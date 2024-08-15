//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See LICENSE file
// in root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension MiscUtilsOnStringExtension on String {
  /// Truncates the string to the given [length].
  String truncToLength(int length) {
    return (this.length > length ? substring(0, length).trim() : this);
  }

  /// Replaces all whitespace characters with [replace].
  String withNormalizedWhitespace([String replace = ' ']) {
    return replaceAll(RegExp(r'[\s]+'), replace);
  }

  /// Replaces the last occurrence of [from] with [replace] starting at
  /// [startIndex].
  ///
  /// See: [replaceFirst].
  String replaceLast(Pattern from, String replace, [int startIndex = 0]) {
    final match = from.allMatches(this, startIndex).lastOrNull;
    if (match == null) return this;
    final lastIndex = match.start;
    final beforeLast = substring(0, lastIndex);
    final group0 = match.group(0);
    if (group0 == null) return this;
    final afterLast = substring(lastIndex + group0.length);
    return beforeLast + replace + afterLast;
  }

  // Splits the string by the last occurrence of [separator].
  List<String> splitByLastOccurrenceOf(String separator) {
    final splitIndex = lastIndexOf(separator);
    if (splitIndex == -1) {
      return [this];
    }
    return [
      substring(0, splitIndex),
      substring(splitIndex + separator.length),
    ];
  }
}
