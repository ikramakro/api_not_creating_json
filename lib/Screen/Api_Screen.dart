import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APiScreen extends StatefulWidget {
  const APiScreen({Key? key}) : super(key: key);

  @override
  State<APiScreen> createState() => _APiScreenState();
}

List<photosmodule> photoslist = [];

Future<List<photosmodule>> getapidata() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map i in data) {
      photosmodule pm = photosmodule(i['id'], i['title'], i['url'],i['thumbnailUrl']);
      photoslist.add(pm);
    }
    return photoslist;
  } else {
    return photoslist;
  }
}

class _APiScreenState extends State<APiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('those api who do not create dart module'),
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: getapidata(),
              builder: (context,AsyncSnapshot<List<photosmodule>> snapshots) {
                return ListView.builder(itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text('ID\n ${snapshots.data![index].id.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text('TITLE \n ${snapshots.data![index].title.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Image.network(snapshots.data![index].url.toString()),
                      // Image.network(snapshots.data![index].thumbnailUrl.toString())


                    ],
                  );
                });
              },
            ))
          ],
        ));
  }
}

class photosmodule {
  String title, url,thumbnailUrl;
  int id;

  photosmodule(this.id, this.title, this.url,this.thumbnailUrl);
}
