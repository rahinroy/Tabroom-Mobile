
import 'package:flutter/material.dart';
import '../class/Paradigm.dart';




class ParaJudgeInfo extends StatefulWidget {

  final String link;
  final String name;

  const ParaJudgeInfo ({ Key key, this.link, this.name}): super(key: key);
  @override
  ParaJudgeInfoState createState() => ParaJudgeInfoState();
}

// ignore: camel_case_types
class ParaJudgeInfoState extends State<ParaJudgeInfo> {

  List formatter(char){
    if (char == "n"){
      return [FontWeight.normal, FontStyle.normal, TextDecoration.none];
    } else if (char == "b"){
      return [FontWeight.bold, FontStyle.normal, TextDecoration.none];
    } else if (char == "i"){
      return [FontWeight.normal, FontStyle.italic, TextDecoration.none];
    } else if (char == "s"){
      return [FontWeight.normal, FontStyle.normal, TextDecoration.lineThrough];
    }
  }

  List<TextSpan> temp(format, word){
//    if (word.)
    List<dynamic> tempL = word.asMap().keys.map<TextSpan>((value) {
      print (value);
      return TextSpan(
          text: word[value],
          style: TextStyle(
            fontWeight: formatter(format[value])[0],
            fontStyle: formatter(format[value])[1],
            decoration: formatter(format[value])[2],
            color: Colors.black,
            fontSize: 16,
          )
      );
    }).toList();
    return tempL;
  }

  List<TextSpan> paraText(word, format){
    var fin = new List<TextSpan>();
    for (var x = 0; x < word.length; x++){
        fin.addAll(temp(format[x], word[x]));
    }
    return fin;
  }


  @override
  Widget build(BuildContext context) {
    Paradigm para = new Paradigm(widget.link);
    return new Scaffold(
      appBar: new AppBar(title: Text(widget.name)),
      body: FutureBuilder(
        future: para.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: RichText(
                    text: TextSpan(
                        children: paraText(para.paraList, para.format)
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