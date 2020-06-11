
import '../main.dart';


class JudgeEvent {
  var room = [];
  var judges = [];
  var entries = [];
  var link;
  var doc;
  var table = [];
  var name;
  var entriesPos = [];
  var header = [];
  var comp = [[]];
  var linkList = [];

  JudgeEvent (tLink) {
    link = tLink;
  }

  Future init() async{
    doc = await construct(link);
    var rowEle = doc.getElementsByTagName("tr");
    var row = [];
    var indiv = [];
    for (var x = 0; x < rowEle.length; x++){
      row = [];
      var isLink = false;
      for (var y = 0; y < rowEle[x].querySelectorAll("td").length; y++){
        indiv = [];
        var inner = rowEle[x].querySelectorAll("td");
        if (indiv.length == 0){
          indiv.add(inner[y].text.trim());
        }
        row.add(indiv);
        if (isLink == false){
          if (inner[1].querySelectorAll("a").length != 0){
            linkList.add(inner[1].querySelectorAll("a")[0].attributes['href']);
          } else {
            linkList.add("");
          }
        }
        isLink = true;
      }
      table.add(row);
    }
    for (var x = 0; x < table.length; x++){
      for (var y = 0; y < table[x].length; y++){
        for (var z = 0; z < table[x][y].length; z++){
          table[x][y][z] = table[x][y][z].replaceAll("\t", " ");
          table[x][y][z] = table[x][y][z].replaceAll("\n", "");
          while (table[x][y][z].contains("  ")){
            table[x][y][z] = table[x][y][z].replaceAll("  ", " ");
          }
        }
      }
    }
    row = [];
    table.removeAt(0);
//    print (table);
    var topRow = doc.getElementsByTagName("tr")[0];
    for (var y = 0; y < topRow.querySelectorAll("th").length; y++){
      row.add(topRow.querySelectorAll("th")[y].text.trim());
    }
    //table[0] = row;
    header = row;
    for (var x = 0; x < row.length; x++){
      if (row[x] == "First" || row[x] == "Last"){
        entriesPos.add(x);
      }
      if (row[x] == ""){
        row[x] = "Entry";
      }
    }
    for (var x = 0; x < table.length; x++){
      var tempList = [];
      for (var y = 0; y < table[x].length; y++){
        var tempString = "";
        if (entriesPos.contains(y)){
          tempString = table[x][y].join("\n");
          tempList.add(tempString);
        }
      }
      comp.add(tempList);
    }
    comp.removeAt(0);
    for (var y = 0; y < table.length; y++){
      for (var x = 0; x < table[y].length; x++){
        table[y][x] = table[y][x].join("");
      }
    }
    header.add("Paradigm");
    header.removeAt(0);
    for (var y = 0; y < table.length; y++){
      table[y].removeAt(0);
    }
  }
}