import 'dart:collection';

class Observation {
  final int order;
  HashMap<int, String> traitOrdersAndValues;

  Observation({required this.order, required this.traitOrdersAndValues});

  Observation.fromJson(Map<String, dynamic> json)
      : order = json['order'],
        traitOrdersAndValues = json['traitOrdersAndValues'];

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'traitOrdersAndValues': traitOrdersAndValues.map((k, v) => MapEntry(k.toString(), v)),
    };
  }
}

/// Mock data
extension MockObservation on Observation {
  static List<Observation> mockData1() {
    return [
      Observation(
          order: 0,
          traitOrdersAndValues: HashMap.from({
            0: "137",
            1: "WA355",
            2: "1",
            3: "",
            4: "Value"
          })
      ),
      Observation(
          order: 1,
          traitOrdersAndValues: HashMap.from({
            0: "128",
            1: "Lanning",
            2: "0",
            3: "",
            4: "Another value"
          })
      ),
    ];
  }

  static List<Observation> mockData2() {
    return [
      Observation(
          order: 2,
          traitOrdersAndValues: HashMap.from({
            0: "284",
            1: "Hale",
            2: "1",
            3: "",
            4: "Sample hidden value"
          })
      ),
      Observation(
          order: 3,
          traitOrdersAndValues: HashMap.from({
            0: "120",
            1: "Glee",
            2: "1",
            3: "",
            4: "Hidden value"
          })
      ),
      Observation(
          order: 4,
          traitOrdersAndValues: HashMap.from({
            0: "180",
            1: "WA8358 CL+",
            2: "0",
            3: "CL+",
            4: "Hidden value"
          })
      ),
    ];
  }
}