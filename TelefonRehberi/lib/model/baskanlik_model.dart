// To parse this JSON data, do
//
//     final baskanlik = baskanlikFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Baskanlik baskanlikFromMap(String str) => Baskanlik.fromMap(json.decode(str));

String baskanlikToMap(Baskanlik data) => json.encode(data.toMap());

class Baskanlik {
  Baskanlik({
    required this.ad,
    required this.mudurluk,
  });

  final String ad;
  final String mudurluk;

  factory Baskanlik.fromMap(Map<String, dynamic> json) => Baskanlik(
    ad: json["ad"],
    mudurluk: json["mudurluk"],
  );

  Map<String, dynamic> toMap() => {
    "ad": ad,
    "mudurluk": mudurluk,
  };
}