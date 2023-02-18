import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telefonrehberi/search.dart';
import 'Mudurlukler.dart';
import '../model/kurum_model.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget{
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    TextEditingController nameController = TextEditingController();
    int kurum;
    String Deneme = "Null";
    kurumJsonOku();
    return Scaffold(
      appBar: AppBar(
        title: Text("Telefon Rehberi"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(Deneme)));
            },
          )
        ],      ),
      body: FutureBuilder<List<Kurum>>(
        future: kurumJsonOku(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Kurum> kurumListesi = snapshot.data!;
            return ListView.builder(
                itemCount: kurumListesi.length,
                itemBuilder: (context, index){
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(color: Colors.grey, width: 0.5)),
                    onPressed: (){
                      kurum = kurumListesi[index].id;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  mudurluk(kurum)));
                    },
                    child: ListTile(
                      title: Text(kurumListesi[index].ad),
                      leading: CircleAvatar(child: Image(image:AssetImage(kurumListesi[index].icon)),backgroundColor: Colors.transparent,),
                    ),
                  );
                });
          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  Future<List<Kurum>> kurumJsonOku() async{
    String okunanString = await rootBundle.loadString('assets/data/kurumlar.json');

    var jsonObject = jsonDecode(okunanString);

    List<Kurum> tumKurumlar = (jsonObject as List)
        .map((kurumMap) => Kurum.fromMap(kurumMap))
        .toList();
    return tumKurumlar;
  }
}
