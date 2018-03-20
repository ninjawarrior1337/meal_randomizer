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

  @override
  initState()
  {
    _getPreferences();
    setState(() => {} );
  }

  _resetPreferences() async
  {
      _places.clear();
      _places.add("Blaze Pizza");
      _places.add("Panda Express");
      _places.add("Chipotle");
      _places.add("In n' Out");
      _places.add("Pho So 1");
      _setPreferences();
  }

  _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_places.length == 0) {
      for (var places in prefs.getStringList("places")) {
        _places.add(places);
      }
    }
    setState(() => {});
  }

  _setPreferences() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("places", _places);
    _getPreferences();
  }

  _removeItem(int id)
  {
    if(_places.length >= 1)
      {
        _places.removeAt(id);
        _setPreferences();
        setState(() => {});
        print("Removed $id");
      }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.restore), onPressed: () => _resetPreferences())
        ],
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
                    mainAxisSize: MainAxisSize.min,
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
                      ),

                      new ButtonTheme.bar(
                        child: new ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new FlatButton(
                                onPressed: () => _removeItem(index),
                                child: const Text("REMOVE")
                            )
                          ],
                        ),
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
