import 'package:variety_testing_app/models/column_visibility.dart';

class Trait {
  final int order;
  final String name;
  final ColumnVisibility columnVisibility;

  Trait({required this.order, required this.name, required this.columnVisibility});

  Trait.fromJson(Map<String, dynamic> json)
      : order = json['order'],
        name = json['name'],
        columnVisibility = json['columnVisibility'];

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'name': name,
      'columnVisibility': columnVisibility.rawValue
    };
  }
}

/// Mock data
extension MockTrait on Trait {
  static List<Trait> mockData() {
    return [
      Trait(order: 0, name: "Entry", columnVisibility: ColumnVisibility.neverShown),
      Trait(order: 1, name: "Variety", columnVisibility: ColumnVisibility.alwaysShown),
      Trait(order: 2, name: "Released", columnVisibility: ColumnVisibility.releasedColumn),
      Trait(order: 3, name: "Traits", columnVisibility: ColumnVisibility.shownByDefault),
      Trait(order: 4, name: "Hidden by default", columnVisibility: ColumnVisibility.hiddenByDefault),
    ];
  }
}