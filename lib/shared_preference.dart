import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///shared preference实现本地存储
class SharedPreferencePage extends StatefulWidget {
  @override
  _SharedPreferencePageState createState() => _SharedPreferencePageState();
}

class _SharedPreferencePageState extends State<SharedPreferencePage> {
  String countString = '';
  String localCount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('shared preference实现本地存储'),),
        body: Column(
          children: <Widget>[
            RaisedButton(
                onPressed: _incrementCounter, child: Text('Increment Counter')),
            RaisedButton(onPressed: _getCounter, child: Text('Get Counter')),
            Text(
              countString,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'result：' + localCount,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countString = countString + " 1";
    });
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt('counter').toString();
    });
  }
}
