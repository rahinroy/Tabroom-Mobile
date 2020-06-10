import 'package:flutter/material.dart';
import 'package:learn/widget/JudgePage.dart';
import '../class/Tourney.dart';

import 'TourneyPage.dart';
import 'EntriesPage.dart';
import 'InvitePage.dart';


class tabPage extends StatefulWidget {

  final String link;
  final String tName;

  const tabPage ({ Key key, this.link, this.tName}): super(key: key);
  @override
  tabPageState createState() => tabPageState();
}

// ignore: camel_case_types
class tabPageState extends State<tabPage> {
  @override
  Widget build(BuildContext context) {
    Tourney tourney = new Tourney(widget.link);

    StatefulWidget ret(val, index){
      if (val == "Results" || val == "Pairings"){
        return tPage(link: tourney.link, ret: val, tId: tourney.tournID);
      } else if (val == "Entries"){
        return entriesPage(link: tourney.link, ret: val, tId: tourney.tournID);
      } else if (val == "Invite"){
        return iPage(tId: tourney.tournID);
      } else if (val == "Judges"){
        return JudgePage(tId: tourney.tournID);
      }
    }
    _refresh() {
      setState(() {});
    }


    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff9ccc65),
        title: Text(widget.tName),
      ),
      body: FutureBuilder(
        future: tourney.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return RefreshIndicator(
                onRefresh: () {
                  return _refresh();
                },
                child: Container(
                child: ListView.separated(
                  itemCount: tourney.tab.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tourney.tab[index]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ret(tourney.tab[index], index))
                        );//style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
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