
import '../main.dart';


class Judges{
  var eventNames = [];
  var eventLinks = [];
  var table = [];
  var link;
  var dom;

  Judges (tLink){
    link = tLink;
  }

  Future init() async {
    dom = await construct(link);
    var roundNamesElements = dom.getElementsByClassName("bigger bordertop martop centeralign");
    var roundLinksList = dom.getElementsByClassName("blue centeralign");
    for (var x = 0; x < roundNamesElements.length; x++){
      eventNames.add(roundNamesElements[x].text.trim());
      print(roundLinksList[x].text.trim());
    }
    for (var x = 0; x < roundLinksList.length; x++){
        if (roundLinksList[x].text.trim() == "Judge List" || roundLinksList[x].text.trim() == "List & Paradigms"){
        eventLinks.add("https://www.tabroom.com" + roundLinksList[x].attributes['href']);
      }
    }
    print (eventLinks);
  }

}