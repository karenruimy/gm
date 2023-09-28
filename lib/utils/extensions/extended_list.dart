extension ExtendedList on List<int> {
  /// Return the sum of given list ...
  int sum() => fold(0, (a, b) => a + b);
}
