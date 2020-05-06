import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp(
      initParams: window.defaultRouteName,
    ));

class MyApp extends StatelessWidget {
  final String initParams;

  const MyApp({Key key, this.initParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 混合开发',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter 混合开发',
        initParams: initParams,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.initParams}) : super(key: key);

  final String title;
  final String initParams;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //用于数据流（event streams）的通信，持续通信，收到消息后无法回复此次消息，通常用于Native向Dart的通信，如：手机电量变化，网络连接变化，陀螺仪，传感器等；
  static const EventChannel _eventChannelPlugin =
      EventChannel('EventChannelPlugin');

  //用于传递方法调用（method invocation）一次性通信：如Flutter调用Native拍照
  static const MethodChannel _methodChannelPlugin =
      const MethodChannel('MethodChannelPlugin');

  //用于传递字符串和半结构化的信息，持续通信，收到消息后可以回复此次消息，如：Native将遍历到的文件信息陆续传递到Dart，在比如：Flutter将从服务端陆陆续获取到信息交个Native加工，Native处理完返回等；
  static const BasicMessageChannel<String> _basicMessageChannel =
      const BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());

  StreamSubscription _streamSubscription;
  String showMessage = "";
  bool _isMethodChannelPlugin = false;

  @override
  void initState() {
    _streamSubscription = _eventChannelPlugin
        .receiveBroadcastStream('123')
        .listen(_onToDart, onError: _onToDartError);

    //使用BasicMessageChannel接受来自Native的消息，并向Native回复
    _basicMessageChannel
        .setMessageHandler((String message) => Future<String>(() {
              setState(() {
                showMessage = 'BasicMessageChannel:' + message;
              });
              return "收到Native的消息：" + message;
            }));
    super.initState();
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

  void _onToDart(message) {
    setState(() {
      showMessage = 'EventChannel:' + message;
    });
  }

  void _onToDartError(error) {
    print(error);
  }

  void _onChanelChanged(bool value) =>
      setState(() => _isMethodChannelPlugin = value);

  void _onTextChange(value) async {
    String response;
    try {
      if (_isMethodChannelPlugin) {
        response = await _methodChannelPlugin.invokeMethod('send', value);
      } else {
        //使用BasicMessageChannel向Native发送消息，并接受Native的回复
        response = await _basicMessageChannel.send(value);
      }
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      showMessage = response ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        margin: EdgeInsets.only(top: 70),
        child: Column(
          children: <Widget>[
            SwitchListTile(
              value: _isMethodChannelPlugin,
              onChanged: _onChanelChanged,
              title: Text(_isMethodChannelPlugin
                  ? "MethodChannelPlugin"
                  : "BasicMessageChannelPlugin"),
            ),
            TextField(
              onChanged: _onTextChange,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            Text(
              '收到初始参数initParams:${widget.initParams}',
              style: textStyle,
            ),
            Text(
              'Native传来的数据：' + showMessage,
              style: textStyle,
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
