import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addPage extends StatefulWidget {
  const addPage({ Key key }) : super(key: key);

  @override
  _addPage createState() => new _addPage();
}
class _addPage extends State<addPage>
{
  List<String> _places = new List();

  _addItem(String newItem)
  {
    _getPreferences();
    _places.add(newItem);
    _setPreferences();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/settings");
  }

  _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var place in prefs.getStringList("places"))
    {
      _places.add(place);
    }
  }

  _setPreferences() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("places", _places);
    print(prefs.getStringList("places"));
  }

  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Item"),
      ),

      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
                padding: new EdgeInsets.all(30.0),
                child: new TextField(
                  controller: _controller,
                  decoration: new InputDecoration(
                      hintText: "Enter place here"
                ),
            )
            ),
            new Padding(
              padding: new EdgeInsets.all(30.0),
              child: new MaterialButton(
                  onPressed: () {
                    if(_controller.text != null)
                      _addItem(_controller.text);
                  },
                child: new Text("Add Place"),
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),

    );
  }
}