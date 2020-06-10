import 'package:flutter/material.dart';
import '../main.dart';

import '../class/Index.dart';
import 'TabPage.dart';



class sPage extends StatefulWidget {

  final String val;

  const sPage ({ Key key, this.val}): super(key: key);
  @override
  sPageState createState() => sPageState();
}

// ignore: camel_case_types
class sPageState extends State<sPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("\"" + widget.val + "\"")),
      body: FutureBuilder(
        future: search(widget.val),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Index indexs = new Index(snapshot.data);
            indexs.init();
            var x = 0;
            return Container(
//              color: Colors.grey,
              child: ListView.separated(
                itemCount: indexs.names.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(indexs.names[index], style: TextStyle(fontSize: 18)),
                    subtitle: Text(indexs.date[index], style: TextStyle(fontSize: 14)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => tabPage(link: indexs.links[index], tName: indexs.names[index])),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            );
          }
          else if(snapshot.hasError){
            throw snapshot.error;
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}