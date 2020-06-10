
import 'package:flutter/material.dart';
import '../class/JudgeEvent.dart';
import '../class/Paradigm.dart';



class JudgeInfoPage extends StatefulWidget {

  final JudgeEvent judgeEvent;
  final int ind;

  const JudgeInfoPage ({ Key key, this.judgeEvent, this.ind}): super(key: key);
  @override
  JudgeInfoPageState createState() => JudgeInfoPageState();
}
class JudgeInfoPageState extends State<JudgeInfoPage> {

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
            info.add(para.para);
            for (var x = 0; x < info.length; x++){
              if(info[x] == ""){
                info[x] = "n/a";
              }
            }
            return Container(
              child: ListView.separated(
                itemCount: info.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(headers[index].toString() + ":\n" + info[index].toString()),
                  );
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
