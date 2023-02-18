import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'main.dart';
import 'model/kisiler_model.dart';


class SearchPage extends StatefulWidget{
  SearchPage(this.Deneme);
  final String Deneme;
  @override
  State<SearchPage> createState() => _SearchPage();
}
class _SearchPage extends State<SearchPage> {


  List<dynamic> wordsList = [];
  List<dynamic> data = [];

  Future<List<Kisiler>> kisilerJsonOku() async{
    String okunanString = await rootBundle.loadString('assets/data/kisiler.json');

    var jsonObject = jsonDecode(okunanString);

    data = await json.decode(okunanString);
    setState(() {
      wordsList = data;
    });

    List<Kisiler> tumKisiler = (jsonObject as List)
        .map((kisilerMap) => Kisiler.fromMap(kisilerMap))
        .toList();
    return tumKisiler;
  }

  List<dynamic> result = [];
  void _onSearch(value) {
    kisilerJsonOku();
    setState(() {
      result = data.where((item) => item["ad_soyad"].toString().toLowerCase().contains(value.toLowerCase())
          || item["daire"].toLowerCase().contains(value.toLowerCase())
          || item["mudurluk"].toLowerCase().contains(value.toLowerCase())
          || item["sube"].toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
    Widget build(BuildContext context) {
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
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding:EdgeInsets.all(10.0) ,
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding:EdgeInsets.all(20.0),
                    labelText: "Ara",
                    hintText: 'Ara...',
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: _onSearch,
                ),
                ),
              Container(
                 child: Expanded(
                   child: result.isNotEmpty
                       ?
                   ListView.builder(
                     itemCount: result.length,
                     itemBuilder: (context, index) {
                      return Card(
                        elevation: 10.0,
                         child: Column(
                           children: [
                             ListTile(
                               title: Text(result[index]["ad_soyad"].toString()),
                               subtitle: Text(result[index]["rutbe"]),
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: <Widget>[
                                 IconButton(
                                   icon: Icon(Icons.phone),
                                   onPressed: () {
                                     if(result[index]["telefon2"].toString() == "null"){
                                       FlutterPhoneDirectCaller.callNumber(result[index]["telefon"].toString());
                                     }else{
                                       showDialog<String>(
                                         context: context,
                                         builder: (BuildContext context) => AlertDialog(
                                           title: Text(result[index]["ad_soyad"]),
                                           content: SingleChildScrollView(
                                             child: ListBody(
                                               children: <Widget>[
                                                 ElevatedButton(
                                                     onPressed: () => FlutterPhoneDirectCaller.callNumber(result[index]["telefon"].toString()),
                                                     child: Text('1.Telefon :'+result[index]["telefon"].toString(),style: TextStyle(fontWeight: FontWeight.bold))),
                                                 ElevatedButton(
                                                     onPressed: () => FlutterPhoneDirectCaller.callNumber(result[index]["telefon2"].toString()),
                                                     child: Text('2.Telefon :'+result[index]["telefon2"].toString(),style: TextStyle(fontWeight: FontWeight.bold),)
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
                                       title: Text(result[index]["ad_soyad"]),
                                       content: SingleChildScrollView(
                                             child: ListBody(
                                               children: <Widget>[
                                               Text('Daire : '+result[index]["daire"],style: TextStyle(fontWeight: FontWeight.bold),),
                                               Text('Şube :'+result[index]["sube"],style: TextStyle(fontWeight: FontWeight.bold),),
                                               Text('Rütbe :'+result[index]["rutbe"],style: TextStyle(fontWeight: FontWeight.bold),),
                                               ElevatedButton(onPressed: () => FlutterPhoneDirectCaller.callNumber(result[index]["telefon"].toString()),
                                                 child: Text('1.Telefon :'+result[index]["telefon"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),),
                                               ElevatedButton(onPressed:  () => FlutterPhoneDirectCaller.callNumber(result[index]["telefon2"].toString()),
                                                 child: Text('2.Telefon :'+result[index]["telefon2"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),)
                                               ],
                                           ),
                                        ),
                                       actions: <Widget>[
                                         ElevatedButton(
                                           onPressed: () => FlutterPhoneDirectCaller.callNumber(result[index]["telefon"].toString()),
                                           child: const Text('Ara'),
                                         ),
                                         ElevatedButton(
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
                      },
                    ) : const Text(
                     '',
                     style: TextStyle(fontSize: 24),
                   ),
                  )
              ),
            ],
          ),
        ),
      );
    }
  }


