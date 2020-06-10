import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../class/Pairings.dart';
import 'RoundPage.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';


class pPage extends StatefulWidget {
  final String link;
  final String pName;
  const pPage ({ Key key, this.link, this.pName}): super(key: key);
  @override
  pPageState createState() => pPageState();
}

var _controller1 = TextEditingController();

class pPageState extends State<pPage> {

  List filteredUsers = List();
  List temp;
  SearchBar searchBar;
  @override
  Widget build(BuildContext context) {
    Pairings pair = new Pairings(widget.link);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text(widget.pName),
      ),
      body: FutureBuilder(
        future: pair.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            int lenTest() {
              if (filteredUsers.length > 0){
                return filteredUsers.length;
              } else {
                return pair.comp.length;
              }
            }

            List listTest() {
              if (filteredUsers.length > 0){
                return filteredUsers;
              } else {
                return pair.comp;
              }
            }
//            final _debouncer = new Debouncer(milliseconds: 400);
            return Column(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    child: TextField(
                    controller: _controller1,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xff9e9e9e),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        suffixIcon: IconButton(
                          onPressed: () {_controller1.clear(); setState((){_controller1.text = "";filteredUsers = pair.comp;}); },
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
                            filteredUsers = pair.comp
                                .where((u) => (u.join()
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                                .toList();
                            _controller1.text = string;
                          });
//                        });
                      }
                    },
                   )
                  ),
                ),
                ListTile(
                  title: Text(pair.start, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: lenTest(),
                    itemBuilder: (context, index) {
//                      print (pair.comp[index]);
                      return ListTile(
                        title: Text(listTest()[index].join("\nvs\n")),
                        onTap: () {
                          int p = index;
                          if (listTest() == filteredUsers){
                            for (var x = 0; x < pair.comp.length; x++) {
                              if (pair.table[x].join().contains(filteredUsers[index].join())){
                                p = x;
                              }
                            }
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => rPage(pair: pair, ind: p)),
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
            print ("efe");
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

