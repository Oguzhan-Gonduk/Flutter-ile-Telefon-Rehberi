// To parse this JSON data, do
//
//     final mudurluk = mudurlukFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Mudurluk mudurlukFromMap(String str) => Mudurluk.fromMap(json.decode(str));

String mudurlukToMap(Mudurluk data) => json.encode(data.toMap());

class Mudurluk {
  Mudurluk({
    required this.id,
    required this.kurum,
    required this.ad,
  });

  final int id;
  final String kurum;
  final String ad;

  factory Mudurluk.fromMap(Map<String, dynamic> json) => Mudurluk(
    id: json["id"],
    kurum: json["kurum"],
    ad: json["ad"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "kurum": kurum,
    "ad": ad,
  };
}
