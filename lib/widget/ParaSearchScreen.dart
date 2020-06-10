import 'package:flutter/material.dart';

import 'ParaSearchResult.dart';


// ignore: camel_case_types
class paraSearchScreen extends StatefulWidget {


  @override
  paraSearchScreenState createState() => paraSearchScreenState();
}

// ignore: camel_case_types
var pastSearch = [];
class paraSearchScreenState extends State<paraSearchScreen>{
  var focusNode = new FocusNode();


  @override
  Widget build(BuildContext context) {
    var _controller1 = TextEditingController();
    var _controller2 = TextEditingController();
    void search(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ParaSearchResult(first: _controller1.text.toString(), last: _controller2.text.toString())),
      );
      var first = _controller1.text.toString();
      var last = _controller2.text.toString();
      if (last == ""){last=" ";}
      if (first == ""){first=" ";}
      pastSearch.add([first, last]);
      setState(() {});
//      _controller2.clear();
//      _controller1.clear();
//      setState(() {
//        _controller2.clear();
//        _controller1.clear();
//      });
    }
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: Color(0xff26c6da),
            title: Text("Paradigms")),
        body:
        Column(children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(8,4,8,8), child: TextField(
            controller: _controller1,

            decoration: InputDecoration(
              labelText: 'First name',
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff000000),
              ),
              border: UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color(0xff212121)
                    ),
              ),
//              enabledBorder: OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: Color(0xff212121), width: 1.5),
//              ),
//              focusedBorder: OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: Color(0xff212121), width: 1.5),
//              ),
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
              focusNode.requestFocus();
//              pastSearch.add(text);
//              setState(() {});
//              onSubmitted(text);
            },
          )),
          Padding(padding: const EdgeInsets.fromLTRB(8,0,8,8), child: TextField(
            controller: _controller2,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: 'Last name',
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff000000),
              ),
              border: UnderlineInputBorder(
                borderSide: new BorderSide(
                    color: Color(0xff212121)
                ),
              ),
//              enabledBorder: OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: Color(0xff212121), width: 1.5),
//              ),
//              focusedBorder: OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: Color(0xff212121), width: 1.5),
//              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              suffixIcon: IconButton(
                onPressed: () => _controller2.clear(),
                icon: Icon(Icons.clear, color: Color(0xff616161)),
              ),
            ),
            style: TextStyle(
              color: Color(0xff000000),
            ),
            autofocus: true,
            onSubmitted: (texts) {
              var text = _controller1.text.toString() + _controller2.text.toString();
              if (text == ""){
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Enter a Judge Name"),
                  content: Text("You left the textboxes blank"),
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
                search();
//                pastSearch.add(text);
                setState(() {});
              }
            },
          )),
          //Color(0xff42a5f5
          Padding(padding: const EdgeInsets.fromLTRB(15,8,15,8), child: InkWell(onTap: () {
            var text = _controller1.text.toString() + _controller2.text.toString();
            if (text == ""){
              Widget okButton = FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              );

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Enter a Judge Name"),
                content: Text("You left the textboxes blank"),
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
              search();
//              pastSearch.add(text);
              setState(() {});
            }
          },child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff26c6da),
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              child: Center(
                child: InkWell(
                  child: new Text("\nSearch\n",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,),
                  ),
              )
          ))),
          Expanded(child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: pastSearch.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.youtube_searched_for,
                ),
                title: Text(pastSearch[pastSearch.length - 1 - index][0] + " " + pastSearch[pastSearch.length - 1 - index][1]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ParaSearchResult(first: pastSearch[pastSearch.length - 1 - index][0], last: pastSearch[pastSearch.length - 1 - index][1])),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          )
          ),
        ])
    );
  }
}
