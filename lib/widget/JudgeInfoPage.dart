
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
    Paradigm para = new Paradigm(widget.judgeEvent.linkList[widget.ind]);
    List info = widget.judgeEvent.table[widget.ind];

    List headers = widget.judgeEvent.header;
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
            if (para.para == ""){
              info.add("No Paradigm Available");
            } else {
              info.add("Click Here For Paradigm");
            }
            for (var x = 0; x < info.length; x++){
              if(info[x] == ""){
                info[x] = "n/a";
              }
            }
            return Container(
              child: ListView.separated(
                itemCount: info.length,
                itemBuilder: (context, index) {
                  return Container(child: ListTile(
                    title: Text(headers[index].toString() + ":\n" + info[index].toString()),
                    onTap: () => switchToPara(info.length, index, para.para, widget.judgeEvent.linkList[widget.ind], (info[0] + " " + info[1]).toString()),
                  ));
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
