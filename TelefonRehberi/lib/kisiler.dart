import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'main.dart';
import 'model/kisiler_model.dart';
import '../search.dart';


class kisiler extends StatefulWidget{

  kisiler(this.mudurluk);
  final String mudurluk;


  @override
  State<kisiler> createState() => _kisiler();
}

class _kisiler extends State<kisiler>{
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context){
    String Deneme = "Null";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telefon Rehberi'),
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
      body: FutureBuilder<List<Kisiler>>(
        future: kisilerJsonOku(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Kisiler> kisilerListesi = snapshot.data!;
            return  ListView.builder(
                itemCount: kisilerListesi.length,
                itemBuilder: (context, index){
                  if(kisilerListesi[index].sube ==  widget.mudurluk) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(kisilerListesi[index].ad_soyad),
                            subtitle: Text(kisilerListesi[index].rutbe),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.phone),
                                  onPressed: () {
                                    if(kisilerListesi[index].telefon2.toString() == null){
                                      FlutterPhoneDirectCaller.callNumber(kisilerListesi[index].telefon.toString());
                                    }else{
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: Text(kisilerListesi[index].ad_soyad),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                ElevatedButton(
                                                    onPressed: () => FlutterPhoneDirectCaller.callNumber(kisilerListesi[index].telefon.toString()),
                                                    child: Text('1.Telefon :'+kisilerListesi[index].telefon.toString(),style: TextStyle(fontWeight: FontWeight.bold))),
                                                ElevatedButton(
                                                    onPressed: () => FlutterPhoneDirectCaller.callNumber(kisilerListesi[index].telefon2.toString()),
                                                    child: Text('2.Telefon :'+kisilerListesi[index].telefon2.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.adjust),
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: Text(kisilerListesi[index].ad_soyad),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('Daire :'+kisilerListesi[index].daire,style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text('Şube :'+kisilerListesi[index].sube,style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text('Rütbe :'+kisilerListesi[index].rutbe,style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text('Telefon :'+kisilerListesi[index].telefon.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => FlutterPhoneDirectCaller.callNumber(kisilerListesi[index].telefon.toString()),
                                        child: const Text('Ara'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    );
                  };
                  return const Center();
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

  Future<List<Kisiler>> kisilerJsonOku() async{
    String okunanString = await rootBundle.loadString('assets/data/kisiler.json');

    var jsonObject = jsonDecode(okunanString);

    List<Kisiler> tumKisiler = (jsonObject as List)
        .map((kisilerMap) => Kisiler.fromMap(kisilerMap))
        .toList();
    return tumKisiler;
  }
}
