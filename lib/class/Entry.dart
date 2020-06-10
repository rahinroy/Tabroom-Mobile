
import '../main.dart';


class Entries {
  var names = [];
  var link;
  var eventNames = [];
  var eventLinks = [];
  

  Entries(links) {
    link = links;
  }
  Future init() async{
    var dom = await construct(link);
    var events = dom.getElementsByClassName("dkblue full");
    events += dom.getElementsByClassName("blue full");
    for (var x = 0; x < events.length; x++){
      eventNames.add(events[x].text.trim());
      eventLinks.add("https://www.tabroom.com/" + events[x].attributes["href"]);
    }
  }
}
