import 'package:flutter/material.dart';
import '../class/Pairings.dart';

import 'entryRecord.dart';

class rPage extends StatefulWidget {

  final Pairings pair;
  final int ind;
  const rPage ({ Key key, this.pair, this.ind}): super(key: key);
  @override
  rPageState createState() => rPageState();
}

// ignore: camel_case_types
class rPageState extends State<rPage> {
  @override
  Widget build(BuildContext context) {
    Pairings pair = widget.pair;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text('Round Information'),
      ),
      body: Container(
              child: ListView.separated(
                itemCount: pair.header.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pair.header[index] + ": \n" + pair.table[widget.ind][index].join("\n")),
                    onTap: () async {
                      if (pair.table[widget.ind][index].length == 1){
                        for (var x = 0; x < pair.href.length; x++){
                          if (pair.hrefText[x].contains(pair.table[widget.ind][index][0])){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => entryRecord(link: pair.href[x], name: pair.hrefText[x])),
                            );
//                            await launch(pair.href[x].toString(), forceWebView: true);
                          }
                        }
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            )
      );
  }
}
