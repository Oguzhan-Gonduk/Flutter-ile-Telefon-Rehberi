// To parse this JSON data, do
//
//     final kurum = kurumFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Kurum kurumFromMap(String str) => Kurum.fromMap(json.decode(str));

String kurumToMap(Kurum data) => json.encode(data.toMap());

class Kurum {
  Kurum({
    required this.id,
    required this.ad,
    required this.icon,
  });

  final int id;
  final String ad;
  final String icon;

  factory Kurum.fromMap(Map<String, dynamic> json) => Kurum(
    id: json["id"],
    ad: json["ad"],
    icon: json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "ad": ad,
    "icon": icon,
  };
}