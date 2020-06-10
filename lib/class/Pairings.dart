
import '../main.dart';


class Pairings {
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
  var start;
  var href = [];
  var hrefText = [];

  Pairings (tLink) {
    link = tLink;
  }

  Future init() async{
    doc = await construct(link);
    name = doc.getElementsByClassName("dkblue full nowrap")[0];
    var tempStart = doc.getElementsByClassName("bluetext");
    if (tempStart.length > 0){
      start = tempStart[0].text.trim().replaceAll("\n", "").replaceAll("\t"," ");
      while (start.contains("  ")){
        start = start.replaceAll("  ", " ");
      }
    } else {
      start = name.text.trim().replaceAll("\n", "").replaceAll("\t","").replaceAll("Round results","").trim();
    }
    var rowEle = doc.getElementsByTagName("tr");
    var row = [];
    var indiv = [];
    for (var x = 0; x < rowEle.length; x++){
      row = [];
      for (var y = 0; y < rowEle[x].querySelectorAll("td").length; y++){
        indiv = [];
        var inner = rowEle[x].querySelectorAll("td");
        for (var z = 0; z < inner[y].querySelectorAll("a,span,div,td").length; z++){
          var ele = inner[y].querySelectorAll("a,span,div,td")[z];
          var tempText = "";
          for (var f = 0; f < ele.querySelectorAll("*").length; f++){
            tempText += (ele.querySelectorAll("*")[f].text.trim());
          }
//          print(tempText);
          var isContained = false;
          if (ele.text.trim().length > (tempText.length + 5)){
            isContained = true;
          }
          if (isContained){
            indiv.add(ele.text.trim());
//            y += ele.querySelectorAll("*").length;
          } else {
//            print("abc");
            if (((ele.getElementsByTagName("*").length == 0)) && ele.text.trim().length > 0){
              if (indiv.length > 1 && !(indiv[indiv.length - 1].contains(ele.text.trim()))){
               indiv.add(ele.text.trim());
              } else if (indiv.length == 0){
                indiv.add(ele.text.trim());
              }
            }
          }
        }
        row.add(indiv);
      }
      table.add(row);
    }

    print ("ahhhhhhhhhhhhhhhhhhhh");
    var tBody = doc.getElementsByTagName("tbody");
    print(tBody[0].querySelectorAll("a").length);
//    for (var x = 0; x < tBody[0].querySelectorAll("a").length; x++) {
//      var linkEle = tBody[0].querySelectorAll("a")[x];
//      var linkVal = linkEle.attributes['href'];
//      var linkText = linkEle.text.trim();
////      linkText = removeTab(linkText);
////      if (linkText.length > 0 && linkVal.contains("entry_record")){
////        linkVal = "https://www.tabroom.com" + linkVal;
////        href.add(linkVal);
////        hrefText.add(linkText);
////      }
//    }

    for (var x = 0; x < tBody[0].querySelectorAll("a").length; x++){
      var linkEle = tBody[0].querySelectorAll("a")[x];
      var linkVal = linkEle.attributes['href'];
      var linkText = linkEle.text.trim();
      linkText = linkText.replaceAll("\n", "");
      linkText = linkText.replaceAll("\t", " ");
      if (linkText.length > 0) {
        if (linkVal.contains("judge")) {
          linkVal = "https://www.tabroom.com/index/tourn/postings/" + linkVal;
          href.add(linkVal);
          hrefText.add(linkText);
        } else if (linkVal.contains("entry_record")) {
          linkVal = "https://www.tabroom.com" + linkVal;
          href.add(linkVal);
          hrefText.add(linkText);
        }
      }
    }
    print ("gbgggggggggggggggg");

//    tBody = doc.getElementsByTagName("tr");
//    for (var x = 0; x < tBody.length; x++){
//
//    }

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
    print ("feeeeeeeeeeee");

    row = [];
    table.removeAt(0);
    var topRow = doc.getElementsByTagName("tr")[0];
    for (var y = 0; y < topRow.querySelectorAll("th").length; y++){
      row.add(topRow.querySelectorAll("th")[y].text.trim());
    }
    //table[0] = row;
    header = row;
    print ("eoneoooooooooooo");

    for (var x = 0; x < row.length; x++){
      if (row[x] == "" || row[x] == "Aff"  || row[x] == "Neg" || row[x] == "Entries" || row[x] == "Entry" || row[x] == "Pro" || row[x] == "Con" || row[x] == "Code"){
        entriesPos.add(x);
      }
      if (row[x] == ""){
        row[x] = "Entry";
      }
    }
    print ("ddddddddddddddddddddd");

    for (var x = 0; x < table.length; x++){
      var tempList = [];
      for (var y = 0; y < table[x].length; y++){
        var tempString = "";
        if (entriesPos.contains(y) && table[x][y].join("").length > 1 && (header[y] == "Aff" || header[y] == "" || header[y] == "Neg" || header[y] == "Pro" || header[y] == "Con")){
          tempString = table[x][y].join(" ");
          tempList.add(tempString);
        } else if (entriesPos.contains(y) && table[x][y].join("").length > 1){
          tempString = table[x][y].join("\n");
          tempList.add(tempString);
        }
      }
      comp.add(tempList);
    }
    comp.removeAt(0);
    print ("pppppppppppppppppppppppp");

    for (var x = 0; x < header.length; x++){
      if (header[x].contains("Points/Ranks")) {
        //half padno  nowrap
        var tempRows = doc.getElementsByTagName("tr");
        for (var x = 1; x < table.length; x++){
          var tempList = [];
          for (var y = 0; y < tempRows[x].getElementsByTagName("td")[4].getElementsByClassName("half padno  nowrap").length; y++){
  //          print(tempRows[x].getElementsByTagName("td")[4].getElementsByClassName("half padno  nowrap")[y].text.trim());
            tempList.add(tempRows[x].getElementsByTagName("td")[4].getElementsByClassName("half padno  nowrap")[y].text.trim());
          }
          for (var z = 0; z < tempList.length; z++){
            tempList[z] = tempList[z].replaceAll("\n", "").replaceAll("\t", " ");
  //          tempList[z] = tempList[z].replaceAll("  ", "-");
            while (tempList[z].contains("  ")){
              tempList[z] = tempList[z].replaceAll("  ", " ");
            }
  //          tempList[z] = removeTab(tempList[z]);
  //          print (tempList[z]);
          }
  //        print (tempList);
          table[x-1][4] = tempList;
        }
      }
    }
  }
}



