import 'package:flutter/material.dart';

import 'S.dart';

void main() => runApp(StatefulGroup());

///StatefulWidget与基础组件
class StatefulGroup extends StatefulWidget {
  @override
  _StatefulGroupState createState() => _StatefulGroupState();
}

class _StatefulGroupState extends State<StatefulGroup> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: S.px(20));
    return MaterialApp(
      title: 'StatefulWidget与基础组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatefulWidget与基础组件'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  title: Text('首页')),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  title: Text('列表'))
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Text('点我'),
        ),
        body: _currentIndex == 0
            ? Column(
                children: <Widget>[
                  Image.network(
                    'http://www.devio.org/img/avatar.png',
                          width: S.px(360),
                          height: S.px(360),
                          fit: BoxFit.fill,
                  ),
                  Flexible(
                    child: ListView(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(S.px(5), 0, 0, 0),
                              hintText: '请输入',
                              hintStyle: TextStyle(fontSize: S.px(15))),
                        ),
                        Container(
                          height: S.px(100),
                          margin: EdgeInsets.only(top: S.px(10)),
                          decoration:
                              BoxDecoration(color: Colors.lightBlueAccent),
                          child: PageView(
                            children: <Widget>[
                              _item('Page1', Colors.deepPurple),
                              _item('Page2', Colors.green),
                              _item('Page3', Colors.red),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5),
                                hintText: '发送消息',
                                hintStyle: TextStyle(fontSize: S.px(12))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: IconButton(
                              icon: Icon(Icons.send, color: Colors.blue),
                              onPressed: null),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Text('列表'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    return null;
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(title,
          style: TextStyle(fontSize: S.px(22), color: Colors.white)),
    );
  }
}
