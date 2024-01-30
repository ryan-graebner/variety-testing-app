import 'dart:collection';

class Observation {
  final int id;
  final HashMap<int, String> traitIDsAndValues;

  Observation({required this.id, required this.traitIDsAndValues});
}

/// Mock data
extension MockObservation on Observation {
  static List<Observation> mockData1() {
    return [
      Observation(
          id: 1,
          traitIDsAndValues: HashMap.from({
            1: "137",
            2: "WA355",
            3: "1",
            4: "",
            5: "Value"
          })
      ),
      Observation(
          id: 2,
          traitIDsAndValues: HashMap.from({
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
          id: 3,
          traitIDsAndValues: HashMap.from({
            1: "284",
            2: "Hale",
            3: "1",
            4: "",
            5: "Sample hidden value"
          })
      ),
      Observation(
          id: 4,
          traitIDsAndValues: HashMap.from({
            1: "120",
            2: "Glee",
            3: "1",
            4: "",
            5: "Hidden value"
          })
      ),
      Observation(
          id: 5,
          traitIDsAndValues: HashMap.from({
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