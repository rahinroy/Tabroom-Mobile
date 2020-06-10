
import 'package:html/dom.dart' as dom;
import '../main.dart';


class Event {
  var eventId;
  var link;
  dom.Document docs;
  var tourneyId;
  var roundNames = [];
  var roundLinks = [];
  var ret;

  Event (tourney_id, event_id, send){
    eventId = event_id.toString();
    tourneyId = tourney_id.toString();
    ret = send.toString();
  }
  Future init() async{
    if (ret == "Pairings"){
      docs = await pairin(tourneyId, eventId);
    } else if (ret == "Results") {
      docs = await result(tourneyId, eventId);
    }
//    var temp = docs.getElementsByClassName("blue full nowrap");
    var temp = docs.getElementsByTagName("a");
    docs = await construct("http://www.tabroom.com" + temp[0].attributes["href"]);
    temp = docs.getElementsByClassName("dkblue full nowrap");
    temp += docs.getElementsByClassName("blue full nowrap");
    for (var x = 0; x < temp.length; x++){
      roundNames.add(temp[x].text.trim());
      roundLinks.add("http://www.tabroom.com" + temp[x].attributes["href"]);
    }
    for (var x = 0; x < roundNames.length; x++){
      if (roundNames[x].contains("Bracket")){
        roundNames.removeAt(x);
        roundLinks.removeAt(x);
      }
    }
    for (var x = 0; x < roundNames.length; x++){
      roundNames[x] = roundNames[x].replaceAll(RegExp(' {2,}'), ' ');
      roundNames[x] = roundNames[x].replaceAll("Round results", "");
      roundNames[x] = roundNames[x].replaceAll(new RegExp(r"\s\b|\b\s"), " ");
      roundNames[x] = roundNames[x].replaceAll("\t", "");
      roundNames[x] = roundNames[x].replaceAll("\n", "");
      roundNames[x] = roundNames[x].replaceAll("  ", " ");
    }
  }
}


