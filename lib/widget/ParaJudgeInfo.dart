
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
  @override
  Widget build(BuildContext context) {
    Paradigm para = new Paradigm(widget.link);
    return new Scaffold(
      appBar: new AppBar(title: Text(widget.name)),
      body: FutureBuilder(
        future: para.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return SingleChildScrollView(child: Padding(padding: const EdgeInsets.fromLTRB(15,0,15,8), child: Container(
//              color: Colors.grey,
              child: Text(para.para, style: TextStyle(fontSize: 15))
            )));
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