import 'package:flutter/material.dart';

import 'SearchResult.dart';





// ignore: camel_case_types
class searchScreen extends StatefulWidget {


  @override
  searchScreenState createState() => searchScreenState();
}

// ignore: camel_case_types
//var pastSearch = [];
//class searchScreenState extends State<searchScreen> {
//
//  void onSubmitted(String value){
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => sPage(val: value)),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        appBar: AppBar(
//          backgroundColor: Color(0xff66bb6a),
//          title: TextField(
//              decoration: InputDecoration(
//                  hintText: 'Search',
//                  prefixIcon: Icon(
//                    Icons.search,
//                    color: Color(0xffeeeeee),
//                  ),
//                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
//                  border: InputBorder.none
//              ),
//              style: TextStyle(
//                color: Color(0xffeeeeee),
//              ),
//              autofocus: true,
//              onSubmitted: (text) {
//                pastSearch.add(text);
//                onSubmitted(text);
//              }
//          ),
//        ),
//        body:
//        Container(
//          child: ListView.separated(
//            itemCount: pastSearch.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                leading: Icon(
//                  Icons.youtube_searched_for,
//                ),
//                title: Text(pastSearch[index]),
//                onTap: () {
//                  onSubmitted(pastSearch[index]);
//                },
//              );
//            },
//            separatorBuilder: (context, index) {
//              return Divider();
//            },
//          ),
//        )
//    );
//  }
//}

var pastSearch = [];
class searchScreenState extends State<searchScreen> {

  void onSubmitted(String value){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => sPage(val: value)),
    );
  }

  @override
  Widget build(BuildContext context) {

    var _controller1 = TextEditingController();

    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff66bb6a),
          title: Text("Tournaments")
        ),
        body: Column(children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(8,4,8,8), child: TextField(
            controller: _controller1,

            decoration: InputDecoration(
              labelText: 'Tournament Name',
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff000000),
              ),
              border: UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color(0xff212121)
                    ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              suffixIcon: IconButton(
                onPressed: () => _controller1.clear(),
                icon: Icon(Icons.clear, color: Color(0xff616161)),
              ),
            ),
            style: TextStyle(
              color: Color(0xff000000),
            ),
            autofocus: true,
            onSubmitted: (text) {
              if (text == ""){
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Enter a Tournament Name"),
                  content: Text("You left the textbox blank"),
                  actions: [
                    okButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              } else {
                onSubmitted(text);
                pastSearch.add(text);
                setState(() {});
              }
            },
          )),
        Padding(padding: const EdgeInsets.fromLTRB(15,8,15,8), child: InkWell(onTap: () {
            var text = _controller1.text.toString();
            if (text == ""){
              Widget okButton = FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              );

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Enter a Tournament Name"),
                content: Text("You left the textbox blank"),
                actions: [
                  okButton,
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            } else {
              onSubmitted(text);
              pastSearch.add(text);
              setState(() {});
            }
          },child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff66bb6a),
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              child: Center(
                child: InkWell(
                  child: new Text("\nSearch\n",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,),
                  ),
              )
          ))),
        Expanded(
          child: ListView.separated(
            itemCount: pastSearch.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.youtube_searched_for,
                ),
                title: Text(pastSearch[pastSearch.length - 1 - index]),
                onTap: () {
                  onSubmitted(pastSearch[pastSearch.length - 1 - index]);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        )
        ])
    );
  }
}
