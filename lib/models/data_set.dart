import 'package:variety_testing_app/models/trait.dart';
import 'observation.dart';

class DataSet {
  final int id;
  final String name;
  final List<Trait> traits;
  final List<Observation> observations;

  DataSet({required this.id, required this.name, required this.traits, required this.observations});
}