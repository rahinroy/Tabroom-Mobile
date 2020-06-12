import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/widget/ParaJudgeInfo.dart';
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


                      List<Widget> getOption() {
                        List<Widget> options = new List();
                        print (pair.judgeHrefText[widget.ind]);
                        for (int i = 0; i < pair.judgeHrefText[widget.ind].length; i++)
                          options.add(new SimpleDialogOption(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ParaJudgeInfo(link: pair.judgeHref[widget.ind][i], name: pair.judgeHrefText[widget.ind][i])),
                              );
                              print (pair.judgeHref[widget.ind][i]);
                            },
                            child: new Text( "• "+ pair.judgeHrefText[widget.ind][i] + "\n", style: TextStyle(fontSize: 20)),//item value
                          ));
                        return options;
                      }

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
                      } if (pair.header[index].contains("Judge")){
                          if (pair.judgeHrefText[widget.ind].length == 1){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ParaJudgeInfo(link: pair.judgeHref[widget.ind][0], name: pair.judgeHrefText[widget.ind][0])),
                            );
                          } else if (pair.judgeHrefText[widget.ind].length > 1) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return new SimpleDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //                                elevation: 16,
                                  title: Text("Click to view paradigms \n", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                                  children: getOption(),
                                );
                              }
                             );
                          }
                        }
                      }
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
