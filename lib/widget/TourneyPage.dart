import 'package:flutter/material.dart';
import '../class/Tourney.dart';
import 'EventPage.dart';
import '../class/Entry.dart';

// ignore: camel_case_types
class tPage extends StatefulWidget {

  final String link;
  final String ret;
  final String tId;
  const tPage ({ Key key, this.link, this.ret, this.tId}): super(key: key);
  @override
  tPageState createState() => tPageState();
}

// ignore: camel_case_types
class tPageState extends State<tPage> {

  StatefulWidget split(tourney, index, rn){
    if (widget.ret == "Results" || widget.ret == "Pairings"){
      return ePage(tId: tourney.tournID, eId: tourney.eventID[index], ret: widget.ret, roundName: rn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Tourney tourney = new Tourney(widget.link);
//    Entries entry = new Entries("https://www.tabroom.com/index/tourn/fields.mhtml?tourn_id=" + widget.tId);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text('Events'),
      ),
      body: FutureBuilder(
        future: tourney.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Container(
              child: ListView.separated(
                itemCount: tourney.eventName.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tourney.eventName[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => split(tourney, index, tourney.eventName[index])),
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