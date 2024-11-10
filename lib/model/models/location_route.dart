// To parse this JSON data, do
//
//     final locationRoute = locationRouteFromJson(jsonString);

import 'dart:convert';

LocationRoute locationRouteFromJson(String str) =>
    LocationRoute.fromJson(json.decode(str));

String locationRouteToJson(LocationRoute data) => json.encode(data.toJson());

class LocationRoute {
  String code;
  List<Route> routes;
  List<Waypoint> waypoints;

  LocationRoute({
    required this.code,
    required this.routes,
    required this.waypoints,
  });

  factory LocationRoute.fromJson(Map<String, dynamic> json) => LocationRoute(
        code: json["code"],
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: List<Waypoint>.from(
            json["waypoints"].map((x) => Waypoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
      };
}

class Route {
  String geometry;
  List<Leg> legs;
  double distance;
  double duration;
  String weightName;
  double weight;

  Route({
    required this.geometry,
    required this.legs,
    required this.distance,
    required this.duration,
    required this.weightName,
    required this.weight,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        geometry: json["geometry"],
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        weightName: json["weight_name"],
        weight: json["weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry,
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "distance": distance,
        "duration": duration,
        "weight_name": weightName,
        "weight": weight,
      };
}

class Leg {
  List<dynamic> steps;
  double distance;
  double duration;
  String summary;
  double weight;

  Leg({
    required this.steps,
    required this.distance,
    required this.duration,
    required this.summary,
    required this.weight,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        summary: json["summary"],
        weight: json["weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "distance": distance,
        "duration": duration,
        "summary": summary,
        "weight": weight,
      };
}

class Waypoint {
  String hint;
  double distance;
  dynamic name;
  List<double> location;

  Waypoint({
    required this.hint,
    required this.distance,
    required this.name,
    required this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        hint: json["hint"],
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "hint": hint,
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
      };
}
