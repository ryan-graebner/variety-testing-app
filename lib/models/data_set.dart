import 'package:variety_testing_app/models/trait.dart';
import 'observation.dart';

class DataSet {
  final int id;
  final String name;
  final List<Trait> traits;
  final List<Observation> observations;

  DataSet({required this.id, required this.name, required this.traits, required this.observations});
}

/// Mock data
extension MockDataSet on DataSet {
  static List<DataSet> mockData() {
    return [
      DataSet(
          id: 1,
          name: "Mock - Spring Barley Low Rainfall (<20\" Precipitation)",
          traits: MockTrait.mockData(),
          observations: MockObservation.mockData1()
      ),
      DataSet(
          id: 2, 
          name:  "Mock - HRS Low Rainfall (<20\" Precip.)",
          traits: MockTrait.mockData(),
          observations: MockObservation.mockData2()
      ),
    ];
  }
}