//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by dev-cetera.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension $StringExtension on String {
  /// Returns null if the String is empty, otherwise returns the String.
  String? get nullIfEmpty {
    return isEmpty ? null : this;
  }

  /// Truncates the string to the given [length]. Specify [ellipsis] to append
  /// to he truncated string if it is shorter than [length], e.g.
  /// 'Hello World'.truncToLength(5, ellipsis: '...') => 'Hello...'.
  String truncToLength(int length, {String ellipsis = ''}) {
    final temp = (this.length > length ? substring(0, length).trim() : this);
    if (temp.length < length) return temp + ellipsis;
    return temp;
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
    return [substring(0, splitIndex), substring(splitIndex + separator.length)];
  }
}
