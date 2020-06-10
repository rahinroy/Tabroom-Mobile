import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../class/Invite.dart';
import 'package:url_launcher/url_launcher.dart';


class iPage extends StatefulWidget {

  final String tId;

  const iPage ({ Key key, this.tId}): super(key: key);
  @override
  iPageState createState() => iPageState();
}

// ignore: camel_case_types
class iPageState extends State<iPage> {
  @override
  Widget build(BuildContext context) {
    Invite inv = new Invite("https://www.tabroom.com/index/tourn/index.mhtml?tourn_id=" + widget.tId);

    List<TextSpan> _createChildren(text, heading, List links) {

      double x;
      var align;
      var bold;
      var linkCounter = 0;
      var url = "";
      var color = Colors.black;
      var decor = TextDecoration.none;
      Uri uri;
      var words;
      return List<TextSpan>.generate(text.length, (int index) {
        if (linkCounter < links.length && text[index] == links[linkCounter].text){
          url = (links[linkCounter].attributes['href'].toString().trim());
          words = links[linkCounter].text;
          uri = Uri.parse(url);
          linkCounter++;
          color = Colors.blue;
          decor = TextDecoration.underline;
        } else {
          words = text[index].toString();
          url = "";
          color = Colors.black;
          decor = TextDecoration.none;
        }
        if (heading[index] == "headline"){
          x = 25;
          align = TextAlign.center;
          bold = FontWeight.bold;
        } else if (heading[index] == "h6"){
          x = 20;
          align = TextAlign.center;
          bold = FontWeight.bold;
        } else {
          x = 18;
          align = TextAlign.left;
          bold = FontWeight.normal;
        }
        if (index < (text.length - 1) && heading[index] != heading[index+1] && words != "") {
          words += "\n";
          print (words);
        }
        if (url == ""){
          if (words.isEmpty){
            return TextSpan(
              text: "\n \n",
              style: TextStyle(
                fontSize: x,
                fontWeight: bold,
                color: color,
                decoration: decor,
              ),
            );
          } else {
            return TextSpan(
              text: words,
              style: TextStyle(
                fontSize: x,
                fontWeight: bold,
                color: color,
                decoration: decor,
              ),
            );
          }
        } else {
          return TextSpan(
            text: words,
            style: TextStyle(
              fontSize: x,
              fontWeight: bold,
              color: color,
              decoration: decor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap  = () async {
                await launch(uri.toString(), forceWebView: true);
              },
          );
        }

      });
    }


    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffef5350),
          title: Text('Invite'),
        ),
        body: FutureBuilder(
          future: inv.init(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: RichText(
                    text: TextSpan(
                      children: _createChildren(inv.textComb, inv.tFormat, inv.links)
                    )
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
