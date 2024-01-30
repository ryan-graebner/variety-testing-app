enum ColumnVisibility {
  neverShown(0),
  hiddenByDefault(1),
  shownByDefault(2),
  alwaysShown(3),
  releasedColumn(4);

  const ColumnVisibility(this.rawValue);
  final int rawValue;
}