
import '../main.dart';

class Home {
  var name = [];
  var link = [];
  var doc;
  var date = [];
  Home ();
  Future init() async {
    var doc = await construct("https://www.tabroom.com/index/index.mhtml");
    var element = doc.getElementsByClassName("white smallish nearfull");
    var dateList = doc.getElementsByClassName("centeralign smallish nowrap");

    var temp;
    for (var y = 0; y < element.length; y++) {
      name.add(element[y].innerHtml.trim());
      link.add("http://www.tabroom.com" + element[y].attributes["href"]);
      temp = dateList[y].text.trim();
      var weirdNum = dateList[y].getElementsByClassName("hidden")[0].innerHtml;
      date.add(temp.replaceAll(weirdNum, "").trim());
    }
  }
}


class Index {
  var names = [];
  var links = [];
  var doc;
  var date = [];
  Index(dom){
    doc = dom;
  }
  init() {
    if (doc.getElementsByTagName("tbody").length == 0){
      if (doc.getElementsByClassName("centeralign marno").length > 0) {
        names.add(doc.getElementsByClassName("centeralign marno")[0].text.trim());
        var tempEle = doc.getElementsByClassName("selected")[0];
        tempEle = tempEle.getElementsByTagName("a")[0];
        links.add("https://www.tabroom.com" + tempEle.attributes['href']);
        date.add("date unavailable");
      }
    } else {
      var element = doc.getElementsByClassName("white");
      for (var y = 0; y < element.length; y++) {
        names.add(element[y].innerHtml.trim().toString());
        links.add("http://www.tabroom.com" + element[y].attributes["href"]);
      }
      var table = doc.getElementsByTagName("tr");
      for (var x = 0; x < table.length; x++){
        var p = table[x].getElementsByTagName("td");
        date.add(p[4].text.trim());
      }
    }
  }
}