import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(LaunchPage());

///如何打开第三方应用？
class LaunchPage extends StatefulWidget {
  LaunchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('如何打开第三方应用？'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _launchURL(),
              child: Text('打开浏览器'),
            ),
            RaisedButton(
              onPressed: () => _openMap(),
              child: Text('打开地图'),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://tianyang.pub/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openMap() async {
    // Android
    const url = 'geo:52.32,4.917'; //APP提供者提供的 schema
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //iOS
      const url = 'http://maps.apple.com/?ll=52.32,4.917';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
