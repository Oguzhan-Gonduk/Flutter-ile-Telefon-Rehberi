import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:rehber/kisiler.dart';
// import 'package:rehber/lib/model/subeler_model.dart';
// import 'package:rehber/search.dart';

import 'kisiler.dart';
import 'main.dart';
import 'model/kisiler_model.dart';
import '../model/subeler_model.dart';
import 'search.dart';


class subeler extends StatefulWidget{

  subeler(this.mudurluk);
  final String mudurluk;


  @override
  State<subeler> createState() => _subeler();
}

class _subeler extends State<subeler>{
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context){
    String Deneme = "Null";
    String mudurluk;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mudurluk),
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
      body: FutureBuilder<List<Subeler>>(
        future: subelerJsonOku(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Subeler> subelerListesi = snapshot.data!;
            return ListView.builder(
                itemCount: subelerListesi.length,
                itemBuilder: (context, index) {
                  if (subelerListesi[index].baskanlik == widget.mudurluk) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.grey, width: 0.5)),
                      onPressed: () {
                        mudurluk = subelerListesi[index].ad;
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    kisiler(mudurluk)));
                      },
                      child: ListTile(
                        title: Text(subelerListesi[index].ad),
                        subtitle: Text(
                            subelerListesi[index].baskanlik),
                      ),
                    );
                  }
                  return const Center();
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          } else {
            return const Center(
              child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
  Future<List<Subeler>> subelerJsonOku() async{
    String okunanString = await rootBundle.loadString('assets/data/subeler.json');

    var jsonObject = jsonDecode(okunanString);

    List<Subeler> tumSubeler = (jsonObject as List)
        .map((subeMap) => Subeler.fromMap(subeMap))
        .toList();
    return tumSubeler;
  }
  Future<List<Kisiler>> kisilerJsonOku() async{
    String okunanString = await rootBundle.loadString('assets/data/kisiler.json');

    var jsonObject = jsonDecode(okunanString);

    List<Kisiler> tumkisiler = (jsonObject as List)
        .map((baskanMap) => Kisiler.fromMap(baskanMap))
        .toList();
    return tumkisiler;
  }
}



