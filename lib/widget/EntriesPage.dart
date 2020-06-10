
import 'package:flutter/material.dart';
import '../class/Entry.dart';
import 'EntryListPage.dart';

// ignore: camel_case_types
class entriesPage extends StatefulWidget {

  final String link;
  final String ret;
  final String tId;

  const entriesPage ({ Key key, this.link, this.ret, this.tId}): super(key: key);
  @override
  entriesPageState createState() => entriesPageState();
}

// ignore: camel_case_types
class entriesPageState extends State<entriesPage> {


  @override
  Widget build(BuildContext context) {
    Entries entry = new Entries("https://www.tabroom.com/index/tourn/fields.mhtml?tourn_id=" + widget.tId);
    print ("https://www.tabroom.com/index/tourn/fields.mhtml?tourn_id=" + widget.tId);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text('Events'),
      ),
      body: FutureBuilder(
        future: entry.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Container(
              child: ListView.separated(
                itemCount: entry.eventNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(entry.eventNames[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => elPage(link: entry.eventLinks[index], roundName: entry.eventNames[index])),
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