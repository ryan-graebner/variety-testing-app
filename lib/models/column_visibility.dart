enum ColumnVisibility {
  neverShown(0),
  hiddenByDefault(1),
  shownByDefault(2),
  alwaysShown(3),
  releasedColumn(4);

  final int rawValue;
  const ColumnVisibility(this.rawValue);

  factory ColumnVisibility.fromNumber(int num) {
    return values.firstWhere((value) => value.rawValue == num);
  }
}