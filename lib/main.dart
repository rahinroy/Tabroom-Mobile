import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:flutter/material.dart';

import 'class/Pairings.dart';
import 'widget/HomePage.dart';
import 'class/Paradigm.dart';

//void main() async{
//  Paradigm pair = new Paradigm("https://www.tabroom.com/index/paradigm.mhtml?search_first=lin&search_last=yi");
//  await pair.init();
////  print(pair.href);
//  print (pair.paraList);
//  print (pair.format);
//}
void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homer(),
    );
  }
}


//temp
// global functions

String removeTab(str) {
  var temp = str.replaceAll("\t", " ");
  temp = temp.replaceAll("\n", "");
  while(str.contains("  ")){
    temp = str.replaceAll("  ", " ");
  }
  return temp;
}

Future<dom.Document> result(tournID, eventID) async {
  final uri = 'https://www.tabroom.com/index/tourn/results/index.mhtml';
  var map = new Map<String, dynamic>();
  map['tourn_id'] = '$tournID';
  map['event_id'] = '$eventID';

  http.Response res = await http.post(
    uri,
    body: map,
  );
  dom.Document pair = parser.parse(res.body);
  return pair;
}


Future<dom.Document> pairin(tournID, eventID) async {
  final uri = 'https://www.tabroom.com/index/tourn/postings/index.mhtml';
  var map = new Map<String, dynamic>();
  map['tourn_id'] = '$tournID';
  map['event_id'] = '$eventID';

  http.Response res = await http.post(
    uri,
    body: map,
  );
  dom.Document pair = parser.parse(res.body);
  return pair;
}


Future<dom.Document> construct(link) async {
  http.Response response = await http.get(link);
  dom.Document doc = parser.parse(response.body);
  return doc;
}


Future<dom.Document> search(term) async {
  String noSpace = term.replaceAll(" ", "+");
  http.Response response = await http.get("https://www.tabroom.com/index/search.mhtml?search=" + noSpace + "&caller=%2Findex%2Findex.mhtml");
  dom.Document doc = parser.parse(response.body);
  return doc;
}


void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}