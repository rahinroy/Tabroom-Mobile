
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:learn/widget/JudgeInfoPage.dart';
import '../class/JudgeEvent.dart';
import 'JudgeInfoPage.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';


class JudgeEventPage extends StatefulWidget {
  final String link;

  const JudgeEventPage ({ Key key, this.link}): super(key: key);
  @override
  JudgeEventPageState createState() => JudgeEventPageState();
}

var _controller1 = TextEditingController();


class JudgeEventPageState extends State<JudgeEventPage> {

  List filteredUsers = List();
  List temp;
  SearchBar searchBar;
  @override
  Widget build(BuildContext context) {
    JudgeEvent judgeEvent = new JudgeEvent(widget.link);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text('Judges'),
      ),
      body: FutureBuilder(
        future: judgeEvent.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            int lenTest() {
              if (filteredUsers.length > 0){
                return filteredUsers.length;
              } else {
                return judgeEvent.comp.length;
              }
            }

            List listTest() {
              if (filteredUsers.length > 0){
                return filteredUsers;
              } else {
                return judgeEvent.comp;
              }
            }
            String nameOrder(index){
              if (listTest()[index].length == 2){
                return listTest()[index][1] + ", " + listTest()[index][0];
              } else {
                return listTest()[index].join(" ");
              }
            }
//            final _debouncer = new Debouncer(milliseconds: 400);
            return Column(
              children: <Widget>[
                SafeArea(
                  child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xff9e9e9e),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          suffixIcon: IconButton(
                            onPressed: () {_controller1.clear(); setState((){
                              _controller1.text = "";
                              filteredUsers = judgeEvent.comp;
                            });},
                            icon: Icon(Icons.clear, color: Color(0xff616161)),
                          ),
                          //border: InputBorder.bottom;
                        ),
                        style: TextStyle(
                          color: Color(0xff000000),
                        ),
                        autofocus: false,
                        onSubmitted: (string) {
                          if (string != ""){
//                        _debouncer.run(() {
                            setState(() {
                              filteredUsers = judgeEvent.comp
                                  .where((u) => (u.join()
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                                  .toList();
                              if (filteredUsers.length == 0){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), title: new Text("No Results Found"));
                                    },
                                );
                                _controller1.text = "";
                              } else {
                                _controller1.text = string;
                              }
                            });
//                        });
                          }
                        },
                      )
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: lenTest(),
                    //itemCount: judgeEvent.comp.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(nameOrder(index)),
                          //title: Text(judgeEvent.comp[index].join(", ")),
                        onTap: () {
                          int p = index;
                          if (listTest() == filteredUsers){
                            for (var x = 0; x < judgeEvent.comp.length; x++) {
                              if (judgeEvent.table[x].join().contains(filteredUsers[index].join())){
                                p = x;
                              }
                            }
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JudgeInfoPage(judgeEvent: judgeEvent, ind: p)),
                          );//style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      );
                    },
                  ),
                ),
              ],
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



class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({ this.milliseconds });

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

