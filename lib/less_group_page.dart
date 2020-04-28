import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() => runApp(LessGroupPage());

///StatelessWidget与基础组件
class LessGroupPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'StatelessWidget与基础组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatelessWidget与基础组件'),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                'I am Text',
                style: textStyle,
              ),
              Icon(
                Icons.android,
                size: 50,
                color: Colors.red,
              ),
              CloseButton(),
              BackButton(),
              Chip(
                avatar: Icon(Icons.people),
                label: Text('StatelessWidget与基础组件'),
              ),
              Divider(
                height: 10, //容器高度，不是线的高度
                indent: 10, //左侧间距
                color: Colors.orange,
              ),
              Card(
                color: Colors.blue,
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'I am Card',
                    style: textStyle,
                  ),
                ),
              ),
              AlertDialog(
                title: Text('盘他'),
                content: Text('啦啦啦啦啦啦啦'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
