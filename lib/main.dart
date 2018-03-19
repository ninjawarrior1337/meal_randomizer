import 'package:flutter/material.dart';
import 'dart:math';
import 'package:meal_randomizer/settings/settings.dart' as settingsPage;
import 'package:meal_randomizer/settings/addItem.dart' as addPage;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() => runApp(
    new MaterialApp(
      home: new MyApp(),
      routes: <String, WidgetBuilder> {
        '/settings': (BuildContext context) => new settingsPage.settingsPage(),
        '/settings/newItem': (BuildContext context) => new addPage.addPage()
      }
    )
);

class MyApp extends StatefulWidget
{
  const MyApp({ Key key }) : super(key: key);

  @override
  _MyApp createState() => new _MyApp();
}

class _MyApp extends State<MyApp> {
  List<String> places = new List();

  _getPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getStringList("places") == null)
    {
      places.add("Blaze Pizza");
      places.add("Panda Express");
      places.add("Chipotle");
      places.add("In n' Out");
      places.add("Pho So 1");
      _setPreferences();
    }
    else
    {
      for (var place in prefs.getStringList("places"))
      {
        places.add(place);
      }
    }
  }

  _setPreferences() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("places", places);
    _getPreferences();
  }

  var _textVal = "Press to get Place";
  Color cbc = Colors.blue;

  int getRand()
  {
    return new Random.secure().nextInt(5);
  }

  void _getPlace(){
    _getPreferences();
    setState((){
      _textVal = '${places[getRand()]}';
      if (cbc == Colors.blue)
      {
        cbc = Colors.greenAccent;
      }
      else
      {
        cbc = Colors.blue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getPreferences();
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
              title: new Text("Friday Randomizer"),
              backgroundColor: Colors.blue,
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(
                      Icons.settings
                  ),
                  onPressed: () => Navigator.of(context).pushNamed("/settings")
              )
            ],
          ),
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Center(
                  child: new Text(
                      _textVal,
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 40.0
                    ),
                  )
              ),
              new Center(
                child: new MaterialButton(
                  onPressed: _getPlace,
                  child: new Text(
                      "Press Me!",
                      style: new TextStyle(
                        color: Colors.black
                      ),
                  ),
                  color: cbc,
                ),
              )
            ],
          ),

        )
    );
  }
}

