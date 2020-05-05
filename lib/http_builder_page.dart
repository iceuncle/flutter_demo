import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///Http实现网络操作
class HttpBuilderPage extends StatefulWidget {
  @override
  _HttpPagetate createState() => _HttpPagetate();
}

class _HttpPagetate extends State<HttpBuilderPage> {
  String showResult = '';

  Future<CommonModel> fectchPost() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    Utf8Decoder utf8decoder = Utf8Decoder();
    final result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http实现网络操作'),
      ),
      body: FutureBuilder<CommonModel>(
          future: fectchPost(),
          builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Input a URL to start');
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              case ConnectionState.active:
                return new Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return new Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return new Column(children: <Widget>[
                    Text('icon:${snapshot.data.icon}'),
                    Text('statusBarColor:${snapshot.data.statusBarColor}'),
                    Text('title:${snapshot.data.title}'),
                    Text('url:${snapshot.data.url}')
                  ]);
                }
            }
            return null;
          }),
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
