
import 'package:flutter/material.dart';

import '../class/Event.dart';
import 'PairingPage.dart';

class ePage extends StatefulWidget {

  final String tId;
  final String eId;
  final String ret;
  final String roundName;
  const ePage ({ Key key, this.tId, this.eId, this.ret, this.roundName}): super(key: key);
  @override
  ePageState createState() => ePageState();
}

// ignore: camel_case_types
class ePageState extends State<ePage> {

  StatefulWidget ent(event, ind, pName){
    if (widget.ret == "Results" || widget.ret == "Pairings"){
      return pPage(link: event.roundLinks[ind], pName: pName);
    }
  }

  _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Event event = new Event(widget.tId, widget.eId, widget.ret);
    return new Scaffold(
      appBar: new AppBar(
      centerTitle: true,
        backgroundColor: Color(0xffab47bc),
        title: Text(widget.roundName),
    ),
      body: FutureBuilder(
        future: event.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return RefreshIndicator(
                onRefresh: () {
                  return _refresh();
                },
                child: Container(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: event.roundNames.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(event.roundNames[index]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                ent(event, index, event.roundNames[index])),
                          );
                        },//style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
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

