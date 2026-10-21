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

extension StringExt1 on String {
  /// Returns null if the String is empty, otherwise returns the String.
  String? get nullIfEmpty {
    return isEmpty ? null : this;
  }

  /// Truncates the string to the given [length], trimming trailing whitespace
  /// that may be exposed by the cut, and appending [ellipsis] if and only if
  /// the string was actually truncated.
  ///
  /// - [length] counts characters as runes (Unicode code points), so a
  ///   character outside the Basic Multilingual Plane, such as an emoji, counts
  ///   as one and is never cut in half.
  /// - Returns the original string unchanged when it has `<= length` runes.
  /// - When truncated, the returned core (before [ellipsis]) is at most
  ///   [length] runes; [ellipsis] is appended on top of that budget.
  /// - [length] must be `>= 0`. Negative values throw [RangeError].
  ///
  /// Examples:
  /// ```dart
  /// 'Hello World'.truncToLength(5, ellipsis: '...'); // 'Hello...'
  /// 'Hello World'.truncToLength(6, ellipsis: '...'); // 'Hello...' (trailing space trimmed)
  /// 'Hello'.truncToLength(10, ellipsis: '...');      // 'Hello' (no truncation)
  /// ''.truncToLength(5, ellipsis: '...');            // '' (no truncation)
  /// '😀😀'.truncToLength(1);                          // '😀'
  /// ```
  String truncToLength(int length, {String ellipsis = ''}) {
    if (length < 0) {
      throw RangeError.range(length, 0, null, 'length');
    }
    // A string never has more runes than UTF-16 code units, so this skips
    // the rune count for strings that are short anyway.
    if (this.length <= length) return this;
    final allRunes = runes.toList();
    if (allRunes.length <= length) return this;
    return String.fromCharCodes(allRunes.take(length)).trimRight() + ellipsis;
  }

  /// Replaces all whitespace characters with [replace].
  String withNormalizedWhitespace([String replace = ' ']) {
    return replaceAll(RegExp(r'[\s]+'), replace);
  }

  /// Replaces the last occurrence of [from] at or after [startIndex] with
  /// [replace].
  ///
  /// - A [String] pattern's last occurrence is the one [lastIndexOf] finds,
  ///   even when it overlaps an earlier one: `'aaa'.replaceLast('aa', 'X')`
  ///   is `'aX'`.
  /// - Any other [Pattern] (e.g. a [RegExp]) replaces the last of its
  ///   non-overlapping matches, the same matches [allMatches] and
  ///   [replaceAll] use.
  ///
  /// Throws [RangeError] if [startIndex] is outside `0..length`.
  ///
  /// See: [replaceFirst].
  String replaceLast(Pattern from, String replace, [int startIndex = 0]) {
    RangeError.checkValueInInterval(startIndex, 0, length, 'startIndex');
    final int start;
    final int end;
    if (from is String) {
      start = lastIndexOf(from);
      if (start < startIndex) return this; // Also covers "not found" (-1).
      end = start + from.length;
    } else {
      final match = from.allMatches(this, startIndex).lastOrNull;
      if (match == null) return this;
      start = match.start;
      end = match.end;
    }
    return substring(0, start) + replace + substring(end);
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
