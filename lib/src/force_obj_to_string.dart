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

/// Converts an object to a string, returning a fallback representation if
/// the object's `toString()` method throws an exception.
///
/// This is a defensive utility, primarily for logging and debugging, to prevent
/// a misbehaving object from crashing the application.
/// In debug mode, it triggers an assertion to notify the developer of the
/// issue.
String forceObjToString(Object? obj) {
  try {
    return obj.toString();
  } catch (e) {
    return '${obj.runtimeType}@${obj.hashCode.toRadixString(16)}';
  }
}

/// An extension method for conveniently calling [forceObjToString].
extension ForceObjToStringOnObjectExtension on Object {
  /// Safely converts this object to a string. See [forceObjToString].
  String forceObjToString() => _forceObjToString(this);
}

// A private alias used by the extension method.
final _forceObjToString = forceObjToString;
