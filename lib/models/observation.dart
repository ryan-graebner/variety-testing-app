import 'dart:collection';

class Observation {
  final int id;
  final HashMap<int, String> traitIDsAndValues;

  Observation({required this.id, required this.traitIDsAndValues});
}