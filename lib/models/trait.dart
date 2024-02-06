import 'package:variety_testing_app/models/column_visibility.dart';

class Trait {
  final int order;
  final String name;
  final ColumnVisibility columnVisibility;

  Trait({required this.order, required this.name, required this.columnVisibility});
}

/// Mock data
extension MockTrait on Trait {
  static List<Trait> mockData() {
    return [
      Trait(order: 1, name: "Entry", columnVisibility: ColumnVisibility.neverShown),
      Trait(order: 2, name: "Variety", columnVisibility: ColumnVisibility.alwaysShown),
      Trait(order: 3, name: "Released", columnVisibility: ColumnVisibility.releasedColumn),
      Trait(order: 4, name: "Traits", columnVisibility: ColumnVisibility.shownByDefault),
      Trait(order: 5, name: "Hidden by default", columnVisibility: ColumnVisibility.hiddenByDefault),
    ];
  }
}