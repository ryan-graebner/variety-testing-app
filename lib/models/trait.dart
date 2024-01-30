import 'package:variety_testing_app/models/column_visibility.dart';

class Trait {
  final int id;
  final String name;
  final ColumnVisibility columnVisibility;

  Trait({required this.id, required this.name, required this.columnVisibility});
}

/// Mock data
extension MockTrait on Trait {
  static List<Trait> mockData() {
    return [
      Trait(id: 1, name: "Entry", columnVisibility: ColumnVisibility.neverShown),
      Trait(id: 2, name: "Variety", columnVisibility: ColumnVisibility.alwaysShown),
      Trait(id: 3, name: "Released", columnVisibility: ColumnVisibility.releasedColumn),
      Trait(id: 4, name: "Traits", columnVisibility: ColumnVisibility.shownByDefault),
      Trait(id: 5, name: "Hidden by default", columnVisibility: ColumnVisibility.hiddenByDefault),
    ];
  }
}