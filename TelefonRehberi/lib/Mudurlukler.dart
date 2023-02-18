import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telefonrehberi/main.dart';
import 'package:telefonrehberi/search.dart';
import 'baskanlik.dart';
import 'model/mudurluk_model.dart';

class mudurluk extends StatefulWidget{

  mudurluk(this.kurum);
  final int kurum;

  @override
  State<mudurluk> createState() => _mudurluk();
}

class _mudurluk extends State<mudurluk> {

 @override
  Widget build(BuildContext context) {
    String Deneme = "null";
    String mudurluk;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Telefon Rehberi"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyApp()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(Deneme)));
            },
          )
        ],
      ),
      body: FutureBuilder<List<Mudurluk>>(
        future: mudurluklerJsonOku(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Mudurluk> mudurlukListesi = snapshot.data!;
            return ListView.builder(
                itemCount: mudurlukListesi.length,
                itemBuilder: (context, index) {
                  if (mudurlukListesi[index].id == widget.kurum) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.grey, width: 0.5)),
                      onPressed: () {
                        mudurluk = mudurlukListesi[index].ad;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => baskanlik(mudurluk)));
                      },
                      child: ListTile(
                        title: Text(mudurlukListesi[index].ad),
                        subtitle: Text(mudurlukListesi[index].kurum),
                      ),
                    );
                  };
                  return Center();
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  Future<List<Mudurluk>> mudurluklerJsonOku() async{
    String okunanString = await rootBundle.loadString('assets/data/mudurlukler.json');

    var jsonObject = jsonDecode(okunanString);

    List<Mudurluk> tumKurumlar = (jsonObject as List)
        .map((kurumMap) => Mudurluk.fromMap(kurumMap))
        .toList();
    return tumKurumlar;
  }
}
