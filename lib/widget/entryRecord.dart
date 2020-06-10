import 'package:flutter/material.dart';

import '../class/Record.dart';

class entryRecord extends StatefulWidget {

  final String link;
  final String name;
  const entryRecord ({ Key key, this.link, this.name}): super(key: key);
  @override
  entryRecordState createState() => entryRecordState();
}

class entryRecordState extends State<entryRecord> {
  @override
  Widget build(BuildContext context) {
    Record record = new Record(widget.link);
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffef5350),
          title: Text(widget.name),
        ),
        body: FutureBuilder(
        future: record.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Container(
              child: ListView.separated(
                itemCount: record.table.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(record.roundNames[index]),
                    subtitle: Text(record.table[index].join("\n")),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => entryRecord(link: record.oppLink[index], name: record.opp[index])),
                      );//style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
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
