import 'dart:collection';

class Observation {
  final int order;
  final HashMap<int, String> traitOrdersAndValues;

  Observation({required this.order, required this.traitOrdersAndValues});
}

/// Mock data
extension MockObservation on Observation {
  static List<Observation> mockData1() {
    return [
      Observation(
          order: 1,
          traitOrdersAndValues: HashMap.from({
            1: "137",
            2: "WA355",
            3: "1",
            4: "",
            5: "Value"
          })
      ),
      Observation(
          order: 2,
          traitOrdersAndValues: HashMap.from({
            1: "128",
            2: "Lanning",
            3: "0",
            4: "",
            5: "Another value"
          })
      ),
    ];
  }

  static List<Observation> mockData2() {
    return [
      Observation(
          order: 3,
          traitOrdersAndValues: HashMap.from({
            1: "284",
            2: "Hale",
            3: "1",
            4: "",
            5: "Sample hidden value"
          })
      ),
      Observation(
          order: 4,
          traitOrdersAndValues: HashMap.from({
            1: "120",
            2: "Glee",
            3: "1",
            4: "",
            5: "Hidden value"
          })
      ),
      Observation(
          order: 5,
          traitOrdersAndValues: HashMap.from({
            1: "180",
            2: "WA8358 CL+",
            3: "0",
            4: "CL+",
            5: "Hidden value"
          })
      ),
    ];
  }
}