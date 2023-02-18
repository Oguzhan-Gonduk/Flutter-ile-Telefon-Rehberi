// To parse this JSON data, do
//
//     final subeler = subelerFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Subeler subelerFromMap(String str) => Subeler.fromMap(json.decode(str));

String subelerToMap(Subeler data) => json.encode(data.toMap());

class Subeler {
  Subeler({
    required this.ad,
    required this.baskanlik,
  });

  final String ad;
  final String baskanlik;

  factory Subeler.fromMap(Map<String, dynamic> json) => Subeler(
    ad: json["ad"],
    baskanlik: json["baskanlik"],
  );

  Map<String, dynamic> toMap() => {
    "ad": ad,
    "baskanlik": baskanlik,
  };
}
