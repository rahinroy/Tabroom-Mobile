import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import '../class/EntryList.dart';
import 'EntryInfo.dart';



class elPage extends StatefulWidget {
  final String link;
  final String roundName;
  const elPage ({ Key key, this.link, this.roundName}): super(key: key);
  @override
  elPageState createState() => elPageState();
}

var _controller1 = TextEditingController();

class elPageState extends State<elPage> {

  List filteredUsers = List();
  List temp;
  SearchBar searchBar;
  @override
  Widget build(BuildContext context) {
    EntryList entryList = new EntryList(widget.link);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text(widget.roundName),
      ),
      body: FutureBuilder(
        future: entryList.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            int lenTest() {
              if (filteredUsers.length > 0){
                return filteredUsers.length;
              } else {
                return entryList.comp.length;
              }
            }

            List listTest() {
              if (filteredUsers.length > 0){
                return filteredUsers;
              } else {
                return entryList.comp;
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
                            onPressed: () {_controller1.clear(); setState((){_controller1.text = "";filteredUsers = entryList.comp;}); },
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
                              filteredUsers = entryList.comp
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
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(listTest()[index].join(" - ")),
                        onTap: () {
                          int p = index;
                          if (listTest() == filteredUsers){
                            for (var x = 0; x < entryList.comp.length; x++) {
                              if (entryList.table[x].join().contains(filteredUsers[index].join())){
                                p = x;
                              }
                            }
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => eInfoPage(el: entryList, ind: p)),
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

