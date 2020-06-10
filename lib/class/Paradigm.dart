
import '../main.dart';

class Paradigm {
  var link;
  var para;
  Paradigm(tlink){
    link = tlink;
  }
  Future init() async {
    if (link == ""){
      para = "No Paradigm Available";
    } else {
      var dom = await construct("http://tabroom.com" + link);
      print ("http://tabroom.com" + link);
      para = dom.getElementsByClassName("paradigm")[0].text;
      para = para.replaceAll("\n", "\n \n");
      para = removeTab(para);
    }
  }
}