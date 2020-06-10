
import '../main.dart';


class ParaLookup{
  var names = [];
  var links = [];
  var link;
  var loc = [];
  var isList = false;
  var para;
  ParaLookup(first, last){
    link = "https://www.tabroom.com/index/paradigm.mhtml?search_first=" + first + "&search_last=" + last;
  }
  Future init() async{
    var dom = await construct(link);
    var tempList = dom.getElementsByClassName("row ltborder padvert martop");
    if (dom.getElementsByClassName("paradigm").length > 0){
      isList = true;
      names.add(dom.getElementsByClassName("twothirds")[0].text.replaceAll("Paradigm", "").trim());
      loc.add("Location Unavailable");
      links.add(link);
    } else {
      for (var x = 0; x < tempList.length; x++){
        names.add(tempList[x].getElementsByTagName("h5")[0].text.trim());
        links.add("http://tabroom.com/index/" + tempList[x].getElementsByTagName("a")[0].attributes['href'].trim());
        loc.add(tempList[x].getElementsByClassName("padless marno full")[0].text.trim());
      }
    }
  }
}