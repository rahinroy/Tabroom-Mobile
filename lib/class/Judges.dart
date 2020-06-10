
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
    var roundLinksList = dom.getElementsByClassName("blue half centeralign");
    for (var x = 0; x < roundNamesElements.length; x++){
      eventNames.add(roundNamesElements[x].text.trim());
      if (roundLinksList[x].text.trim() == "Judge List"){
        eventLinks.add("https://www.tabroom.com" + roundLinksList[x].attributes['href']);
      }
    }
    print (eventLinks);
  }

}