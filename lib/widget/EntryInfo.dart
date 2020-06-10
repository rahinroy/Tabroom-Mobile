
import 'package:flutter/material.dart';

import '../class/EntryList.dart';


class eInfoPage extends StatefulWidget {

  final EntryList el;
  final int ind;

  const eInfoPage ({ Key key, this.el, this.ind}): super(key: key);
  @override
  eInfoPageState createState() => eInfoPageState();
}

// ignore: camel_case_types
class eInfoPageState extends State<eInfoPage> {
  @override
  Widget build(BuildContext context) {
    EntryList entry = widget.el;
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffef5350),
          title: Text('Round Information'),
        ),
        body: Container(
          child: ListView.separated(
            itemCount: entry.header.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(entry.header[index] + ": \n" + entry.table[widget.ind][index].join()),
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
