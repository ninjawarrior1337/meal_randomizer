import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({ Key key }) : super(key: key);

  @override
  _settingsPage createState() => new _settingsPage();
}

class _settingsPage extends State<settingsPage> {
  List<String> _places = new List();

  _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_places.length == 0) {
      for (var places in prefs.getStringList("places")) {
        _places.add(places);
      }
    }
  }

  _setPreferences() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    _getPreferences();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),

      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/settings/newItem"),
        child: new Icon(Icons.add),
      ),

      body: new Container(
          child: new ListView.builder(
              itemCount: _places == null ? 0 : _places.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(

                  child: new Column(
                    children: <Widget>[
                      new Center(
                          child: new Padding(
                            padding: new EdgeInsets.all(15.0),
                            child: new Text(
                              _places[index],
                              style: new TextStyle(
                                  fontSize: 40.0
                              ),
                            ),
                          )
                      )
                    ],
                  ),

                );
              }
          )
      ),
    );
  }
}
