import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///Http实现网络操作
class HttpPage extends StatefulWidget {
  @override
  _HttpPagetate createState() => _HttpPagetate();
}

class _HttpPagetate extends State<HttpPage> {
  String showResult = '';

  Future<CommonModel> fectchPost() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http实现网络操作'),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              fectchPost().then((CommonModel value) {
                setState(() {
                  showResult =
                      '请求结果：hideAppBar：${value.hideAppBar}icon：${value.icon}';
                });
              });
            },
            child: Text(
              '点我',
              style: TextStyle(fontSize: 26),
            ),
          ),
          Text(showResult),
        ],
      ),
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
