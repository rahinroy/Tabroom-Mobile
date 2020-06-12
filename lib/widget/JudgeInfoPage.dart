
import 'package:flutter/material.dart';
import '../class/JudgeEvent.dart';
import '../class/Paradigm.dart';
import 'ParaJudgeInfo.dart';


class JudgeInfoPage extends StatefulWidget {

  final JudgeEvent judgeEvent;
  final int ind;

  const JudgeInfoPage ({ Key key, this.judgeEvent, this.ind}): super(key: key);
  @override
  JudgeInfoPageState createState() => JudgeInfoPageState();
}
class JudgeInfoPageState extends State<JudgeInfoPage> {


  switchToPara(len, index, paraStr, paraLink, name) {
    if (index == (len - 1)){
      if (paraStr != ""){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParaJudgeInfo(link: "http://tabroom.com" + paraLink, name: name)),
        );
      }
    }
  }
  @override
  // ignore: camel_case_types
  Widget build(BuildContext context) {
//    print (widget.judgeEvent.linkList);
    Paradigm para = new Paradigm("https://www.tabroom.com" + widget.judgeEvent.linkList[widget.ind]);
    List info = widget.judgeEvent.table[widget.ind];
    List headers = widget.judgeEvent.header;


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
      var tempSpan = TextSpan(
                      text: "Paradigm:\n\n",
                      style: TextStyle(
                        fontWeight: formatter("b")[0],
                        fontStyle: formatter("b")[1],
                        decoration: formatter("b")[2],
                        color: Colors.black,
                        fontSize: 16,
                      ));
      fin.insert(0, tempSpan);
      return fin;
    }




  //    print ("https://www.tabroom.com/index/tourn/judges.mhtml?tourn_id=" + widget.tId);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text('Judge Information'),
      ),
      body: FutureBuilder(
        future: para.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            for (var x = 0; x < info.length; x++){
              if(info[x] == ""){
                info[x] = "n/a";
              }
            }
            return Container(
              child: ListView.separated(
                itemCount: info.length + 1,
                itemBuilder: (context, index) {
                  if (index == info.length){
                    print (widget.judgeEvent.linkList[widget.ind]);
                    return Container(child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(15, 0, 10, 20), child:RichText(
                          text: TextSpan(
                              children: paraText(para.paraList, para.format)
                          )
                      )
                    ));
                  } else {
                    return Container(child: ListTile(
                      title: Text(headers[index].toString() + ":\n" + info[index].toString()),
                      onTap: () => switchToPara(info.length, index, para.para, widget.judgeEvent.linkList[widget.ind], (info[0] + " " + info[1]).toString()),
                    ));
                  }
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
