
import 'package:html/dom.dart' as dom;
import '../main.dart';



class Tourney {
  var name;
  var link;
  var tab = [];
  var tabLinks = [];
  var document;
  String tournID;
  var eventID = [];
  var eventName = [];

  Tourney (var tLink){
    link = tLink;
  }
  Future<dom.Document> init() async{
//    document = doc;
    document = await construct(link);
    var temp = document.getElementsByTagName("ul")[1];
//    print (temp.getElementsByTagName("li").length);
    for (var x = 0; x < temp.getElementsByTagName("li").length; x++){
      tab.add(temp.getElementsByTagName("li")[x].text.trim());
//      print (tab[x]);
      tabLinks.add("http://www.tabroom.com" + temp.getElementsByTagName("li")[x].getElementsByTagName("a")[0].attributes["href"]);
    }
    name = document.getElementsByClassName("centeralign marno")[0].innerHtml.trim();
    tournID = link.substring(link.length - 5);
    for (var x = 0; x < tab.length; x++){
      if (tab[x] == "Pairings"){
        var pair = await construct(tabLinks[x]);
        var eventElements = pair.getElementsByTagName("option");
        for (var y = 1; y < eventElements.length; y++){
          eventName.add(eventElements[y].innerHtml);
          eventID.add(eventElements[y].attributes["value"].trim());
        }
      }
    }

    for (var x = 0; x < tab.length; x++){
      print (x);
      if (!(tab[x].contains("Pairings") || tab[x].contains("Results") || tab[x].contains("Invite") || tab[x].contains("Entries") || tab[x].contains("Judges"))) {
        tab.removeAt(x);
        tabLinks.removeAt(x);
        x = x - 1;
      }
      if (tab[x].contains(" ")){
        tab.removeAt(x);
        tabLinks.removeAt(x);
        x = x - 1;
      }
    }
  }
}

