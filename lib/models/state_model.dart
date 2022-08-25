// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    required this.india,
  });

  List<India> india;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        india: List<India>.from(json["india"].map((x) => India.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "india": List<dynamic>.from(india.map((x) => x.toJson())),
      };
}

class India {
  India({
    required this.state,
    required this.cities,
  });

  String state;
  List<String> cities;

  factory India.fromJson(Map<String, dynamic> json) => India(
        state: json["state"],
        cities: List<String>.from(json["cities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "cities": List<dynamic>.from(cities.map((x) => x)),
      };
}
