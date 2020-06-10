
import '../main.dart';


class Invite{
  var html;
  var link;
  var ele = [];
  var div;
  var str;
  var text = [];
  var tFormat = [];
  var tLink = [];
  var links = [];
  var textComb = [];
  Invite(links){
    link = links;
  }
  Future init() async{
    var dom = await construct(link);
    div = dom.getElementsByClassName("main index")[0];
    ele = div.querySelectorAll("h1,h2,h3,h4,h5,h6,p");
    links = div.querySelectorAll("a");

    for (var x = 0; x < ele.length; x++){
      text.add(ele[x].text.trim());
//      tFormat.add(ele[x].outerHtml.substring(0,3));
      tLink.add(ele[x].attributes["href"]);
    }
    for (var x = 0; x < ele.length; x++){
      if (x < (ele.length - 1) && ele[x].text == ele[x+1].text){
        ele.removeAt(x);
        x--;
      }
    }

      ele.removeAt(0);
//    tFormat.removeAt(0);
    tLink.removeAt(0);
    ele.removeAt(0);
//    tFormat.removeAt(0);
    tLink.removeAt(0);

    for (var x = 0; x < links.length; x++){
      if (links[x].attributes["href"].contains("index/tourn")){
        links.removeAt(x);
        x = x - 1;
      }
    }
    var linkCounter = 0;
    for (var x = 0; x < ele.length; x++){
      if (linkCounter < links.length && ele[x].text.contains(links[linkCounter].text)){
        var tempList = [];
        var tempTerm = " " + ele[x].text.trim() + " ";
        var tempLen = textComb.length;
        var tempLoop = false;
        while (linkCounter < links.length && tempTerm.contains(links[linkCounter].text) ){
          if (tempLoop){
            textComb.removeLast();
          }
          tempList = tempTerm.split(links[linkCounter].text.trim());
          textComb.add(tempList[0].substring(1, tempList[0].length));
          textComb.add(links[linkCounter].text.trim());
          textComb.add(tempList[1]);
          linkCounter++;
          tempTerm = tempList[1].trim();
          tempLoop = true;
        }
        var lenChanged = textComb.length - tempLen;
        for (var z = 0; z < lenChanged; z++){
          tFormat.add(ele[x].outerHtml.substring(0,3));
        }
      } else {
        textComb.add(ele[x].text.trim());
        tFormat.add(ele[x].outerHtml.substring(0,3));
      }
    }
//    print(links[0].attributes["href"]);

//    print (text);
//    for (var x = 0; x < textComb.length; x++){
//      var tempList = textComb;
//      tempList.removeAt(x);
//      if ((x+1) < textComb.length && tempList.contains(textComb[x]) && textComb[x].length > 1){
//        print (textComb[x]);
//        textComb.removeAt(x);
//        tFormat.removeAt(x);
//        x--;
//      }
//    }
    while (textComb[0].isEmpty){
      textComb.removeAt(0);
      tFormat.removeAt(0);
    }

    for (var x = 0; x < textComb.length; x++){
      textComb[x] = textComb[x].replaceAll("\n", "");
      textComb[x] = textComb[x].replaceAll("\t", "");
      if (tFormat[x].contains("6")) {
        tFormat[x] = "h6";
      } else if (tFormat[x].contains("h")){
        tFormat[x] = "headline";
      } else {
        tFormat[x] = "body";
      }
    }
    print (textComb[0].length);
//    print (tFormat);
//    for (var x = 0; x < textComb.length; x++){
//      print (textComb[x]);
//    }

  }
}