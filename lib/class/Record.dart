

import '../main.dart';

class Record{
  var name;
  var link;
  var roundNames = [];
  var results = [];
  var opp = [];
  var oppLink = [];
  var side = [];
  var table = [[]];

  Record(tlink){
    link = tlink;
  }
  Future init() async{
    var doc = await construct(link);
    var rows = doc.getElementsByClassName("row");
    for (var x  = 0; x < rows.length; x++){
      var tempText = [];
      for (var y = 0; y < rows[x].querySelectorAll("span,a").length; y++){
        var tempEle = rows[x].querySelectorAll("span,a")[y];
        if (tempEle.querySelectorAll("*").length == 0){
          tempText.add(tempEle.text.trim().replaceAll("\t", "").replaceAll("\n", ""));
//          print(rows[x].getElementsByClassName("threetenths padno")[y].text);
          if (tempEle.text.trim().contains("vs")){
            oppLink.add("https://www.tabroom.com/index/tourn/postings/" + tempEle.attributes['href']);
            var tempName = tempEle.text.trim().replaceAll("\t", "").replaceAll("\n", "");
            tempName = tempName.substring(3,tempName.length);
            opp.add(tempName);
          }
        }
      }
      print (tempText);
      if (tempText[1] == "Bye"){
        opp.add("BYE");
        oppLink.add("");
      }
      for (var z = 1; z < tempText.length; z++){
        if (tempText[z].length < 3 || (tempText[z].length == 4 && tempText[z].contains("."))){
          tempText[z-1] = tempText[z-1] + " --- " + tempText[z];
          tempText.removeAt(z);
          z = z - 1;
        }
      }
      table.add(tempText);
    }
    table.removeAt(0);
    for (var x = 0; x < table.length; x++){
      roundNames.add(table[x][0]);
      table[x].removeAt(0);
    }
  }
}