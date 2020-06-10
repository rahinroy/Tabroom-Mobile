
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
          tempText.add(removeTab(tempEle.text.trim()));
          if (tempEle.text.trim().contains("vs")){
            oppLink.add("https://www.tabroom.com/index/tourn/postings/" + tempEle.attributes['href']);
            var tempName = removeTab(tempEle.text.trim());
            tempName = tempName.substring(3,tempName.length);
            opp.add(tempName);
          }
        }
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
//    var roundNamesEle = doc.getElementsByClassName("tenth semibold");
//    for (var x = 0; x < roundNamesEle.length; x++){
//      roundNames.add(removeTab(roundNamesEle[x].text.trim()));
//    }
//    var resultsEle = doc.getElementsByClassName("tenth centeralign semibold");
//    for (var x = 0; x < resultsEle.length; x++){
//      results.add(removeTab(resultsEle[x].text.trim()));
//    }
//    var oppEle = doc.getElementsByClassName("white padtop padbottom");
//    for (var x = 0; x < oppEle.length; x++){
//      opp.add(removeTab(oppEle[x].text.trim()));
//      oppLink.add(oppEle[x].attributes['href']);
//    }
//    var sideEle = doc.getElementsByClassName("tenth semibold");
//    for (var x = 0; x < sideEle.length; x++){
//      side.add(removeTab(sideEle[x].text.trim()));
//    }
  }
}