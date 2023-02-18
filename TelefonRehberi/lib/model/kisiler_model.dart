// To parse this JSON data, do
//
//     final kisiler = kisilerFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Kisiler kisilerFromMap(String str) => Kisiler.fromMap(json.decode(str));

String kisilerToMap(Kisiler data) => json.encode(data.toMap());

class Kisiler {
  Kisiler({
    required this.kurum,
    required this.mudurluk,
    required this.daire,
    required this.sube,
    required this.ad_soyad,
    required this.telefon,
    this.telefon2,
    required this.rutbe,
  });

  final String kurum;
  final String mudurluk;
  final String daire;
  final String sube;
  final String ad_soyad;
  final String telefon;
  final String? telefon2;
  final String rutbe;

  factory Kisiler.fromMap(Map<String, dynamic> json) => Kisiler(
    kurum: json["kurum"],
    mudurluk: json["mudurluk"],
    daire: json["daire"],
    sube: json["sube"],
    ad_soyad: json["ad_soyad"],
    telefon: json["telefon"],
    telefon2: json["telefon2"],
    rutbe: json["rutbe"],
  );

  Map<String, dynamic> toMap() => {
    "kurum": kurum,
    "mudurluk": mudurluk,
    "daire": daire,
    "sube": sube,
    "ad_soyad": ad_soyad,
    "telefon": telefon,
    "telefon2": telefon2,
    "rutbe": rutbe,
  };
}
