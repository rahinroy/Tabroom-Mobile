import 'package:flutter/material.dart';
import 'package:learn/class/ParaLookup.dart';
import 'ParaJudgeInfo.dart';


class ParaSearchResult extends StatefulWidget {

  final String first;
  final String last;

  const ParaSearchResult ({ Key key, this.first, this.last}): super(key: key);
  @override
  ParaSearchResultState createState() => ParaSearchResultState();
}

// ignore: camel_case_types
class ParaSearchResultState extends State<ParaSearchResult> {
  @override
  Widget build(BuildContext context) {
    ParaLookup lookup = new ParaLookup(widget.first, widget.last);
    return new Scaffold(
      appBar: new AppBar(title: Text("\"" + widget.first + " " + widget.last + "\"")),
      body: FutureBuilder(
        future: lookup.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            var x = 0;
            return Container(
//              color: Colors.grey,
              child: ListView.separated(
                itemCount: lookup.names.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(lookup.names[index], style: TextStyle(fontSize: 18)),
                    subtitle: Text(lookup.loc[index], style: TextStyle(fontSize: 14)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ParaJudgeInfo(link: lookup.links[index], name: lookup.names[index])),
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