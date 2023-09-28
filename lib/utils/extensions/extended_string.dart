extension ExtendedString on String {
  /// Remove all spaces in given string/value ...

  String removeSpaces() {
    return replaceAll(' ', '').trim();
  }

  String toCapitalize() {
    return isEmpty ? '' : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String toCapitaliseEachWordFirstChar() {
    return replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalize).join(' ');
  }

  double toDouble() => double.parse(this);

  int toInt() => int.parse(this);

  Uri toUri() => Uri.parse(this);

  bool get isUrl => contains('https://') || contains('http://');
}
