import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class ChoferInfo {
  final String id;
  final String nombre;
  final double rating;
  final int viajes;
  final double deficitPromedio;

  const ChoferInfo(
      {required this.id,
      required this.nombre,
      required this.rating,
      required this.viajes,
      required this.deficitPromedio});

  factory ChoferInfo.fromJson(Object json) {
    print(json.runtimeType);
    Map<String, dynamic> jsonDecoded = Map<String, dynamic>.from(json as Map);
    print("Json $jsonDecoded");
    return ChoferInfo(
      id: jsonDecoded['Id'].toString(),
      nombre: jsonDecoded['CamioneroID'].toString(),
      rating: (jsonDecoded['Rating'] ?? 0.0).toDouble(),
      viajes: (jsonDecoded['Viajes'] ?? 0).toInt(),
      deficitPromedio: (jsonDecoded['DeficitPromedio'] ?? 0.0).toDouble(),
    );
  }
}
