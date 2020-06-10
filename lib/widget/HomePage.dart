
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import '../class/Index.dart';
import 'SearchScreen.dart';
import 'SearchResult.dart';
import 'TabPage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'ParaSearchScreen.dart';

class Homer extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Homer> {
  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Tabroom'),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  void onSubmitted(String value){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => sPage(val: value)),
    );
  }

  List allItems = new List();

  _HomeState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: onSubmitted,
        buildDefaultAppBar: buildAppBar
    );
  }

  List showData(dom) {
    Home home  = new Home();
    home.init();
    List title = home.name;
//    print (title);
    return title;
  }

  List showLinks(dom) {
    Home home  = new Home();
    home.init();
    List links = home.link;
//    print (title);
    return links;
  }
  @override
  Widget build(BuildContext context) {
    Home home = new Home();
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffffa726),
        title: Text('Tabroom'),
      ),
      body: FutureBuilder(
        future: home.init(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
//            print (home.name);
            return Container(
              child: ListView.separated(
                itemCount: home.name.length,
                itemBuilder: (context, index) {
                  return ListTile(
//                    dense:true,
                    title: Text(home.name[index], style: TextStyle(fontSize: 18)),
                    subtitle: Text(home.date[index], style: TextStyle(fontSize: 14)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => tabPage(link: home.link[index], tName: home.name[index])),
                      );
                    },
//                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            );
          }
          else if(snapshot.hasError){
            throw snapshot.error;
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SpeedDial(
          child: Icon(Icons.search),
        backgroundColor: Color(0xffffa726),
        children: [
          SpeedDialChild(
            backgroundColor: Color(0xff66bb6a),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => searchScreen()),
              ),
            },
            label: "Tournaments",
            child: Icon(Icons.gavel),
          ),
          SpeedDialChild(
            backgroundColor: Color(0xff29b6f6),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => paraSearchScreen()),
              ),
            },
            label: "Paradigms",
            child: Icon(Icons.sentiment_dissatisfied),
          ),
        ]
      ),
    );
  }
}
