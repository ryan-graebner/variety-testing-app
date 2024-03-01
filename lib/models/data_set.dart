import 'package:variety_testing_app/models/trait.dart';
import 'observation.dart';

class DataSet {
  final int order;
  final String name;
  final List<Trait> traits;
  final List<Observation> observations;

  DataSet({required this.order, required this.name, required this.traits, required this.observations});

  factory DataSet.fromJson(Map<String, dynamic> json) {
    List<Trait> traits = [];
    List<Observation> observations = [];

    for (final trait in json['traits']) {
      Trait deserializedTrait = Trait.fromJson(trait as Map<String, dynamic>);
      traits.add(deserializedTrait);
    }

    for (final observation in json['observations']) {
      Observation deserializedObservation = Observation.fromJson(observation as Map<String, dynamic>);
      observations.add(deserializedObservation);
    }

    return DataSet(order: json['order'], name: json['name'], traits: traits, observations: observations);
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'name': name,
      'traits': traits.map((t) => t.toJson()).toList(),
      'observations': observations.map((o) => o.toJson()).toList(),
    };
  }
}

/// Mock data
extension MockDataSet on DataSet {
  static List<DataSet> mockData() {
    return [
      DataSet(
          order: 0,
          name: "Mock - Spring Barley Low Rainfall (<20\" Precipitation)",
          traits: MockTrait.mockData(),
          observations: MockObservation.mockData1()
      ),
      DataSet(
          order: 1, name: "Mock - HRS Low Rainfall (<20\" Precip.)",
          traits: MockTrait.mockData(),
          observations: MockObservation.mockData2()
      ),
    ];
  }
}