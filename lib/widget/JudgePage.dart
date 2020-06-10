import 'package:flutter/material.dart';

import '../class/Judges.dart';
import 'JudgeEventPage.dart';

// ignore: camel_case_types
class JudgePage extends StatefulWidget {

  final String link;
  final String ret;
  final String tId;
  const JudgePage ({ Key key, this.link, this.ret, this.tId}): super(key: key);
  @override
  JudgePageState createState() => JudgePageState();
}

// ignore: camel_case_types
class JudgePageState extends State<JudgePage> {


  @override
  Widget build(BuildContext context) {
    Judges judges = new Judges("https://www.tabroom.com/index/tourn/judges.mhtml?tourn_id=" + widget.tId);
//    print ("https://www.tabroom.com/index/tourn/judges.mhtml?tourn_id=" + widget.tId);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffef5350),
        title: Text('Events'),
      ),
      body: FutureBuilder(
        future: judges.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Container(
              child: ListView.separated(
                itemCount: judges.eventNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(judges.eventNames[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JudgeEventPage(link: judges.eventLinks[index])),
                      );//style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                    },
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