import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telefonrehberi/search.dart';
import 'package:telefonrehberi/subeler.dart';
import 'main.dart';
import 'model/baskanlik_model.dart';
import 'model/kisiler_model.dart';

class baskanlik extends StatefulWidget{

  baskanlik(this.mudurluk);
  final String mudurluk;


  @override
  State<baskanlik> createState() => _baskanlik();
}

class _baskanlik extends State<baskanlik>{
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context){
    String Deneme = "Null";
    String mudurluk;
    baskanlikJsonOku();
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
      body: SafeArea(
        child:  Column(
          children: [
            Container(
              width: 500,
              height: 570,
                child: FutureBuilder<List<Baskanlik>>(
                  future:  baskanlikJsonOku(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      List<Baskanlik> baskanlikListesi = snapshot.data!;
                      return  ListView.builder(
                          itemCount: baskanlikListesi.length,
                          itemBuilder: (context, index){
                            if(baskanlikListesi[index].mudurluk == widget.mudurluk){
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    side: BorderSide(color: Colors.grey, width: 0.5)),
                                onPressed: () {
                                   mudurluk = baskanlikListesi[index].ad;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => subeler(mudurluk)));
                                },
                                child: ListTile(
                                  title: Text(baskanlikListesi[index].ad),
                                  subtitle: Text(baskanlikListesi[index].mudurluk),
                                ),
                              );
                            }
                            return const Center();
                          });
                    }else if(snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()),);
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
          ],
        )
      ),
    );
  }
  Future<List<Baskanlik>> baskanlikJsonOku() async{
    String okunanString = await rootBundle.loadString('assets/data/baskanlik.json');

    var jsonObject = jsonDecode(okunanString);

    List<Baskanlik> tumBaskanlik = (jsonObject as List)
        .map((baskanMap) => Baskanlik.fromMap(baskanMap))
        .toList();
    return tumBaskanlik;
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



