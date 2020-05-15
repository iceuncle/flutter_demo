import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:my_app/hero.dart';
import 'package:my_app/photo_app.dart';
import 'package:my_app/plugin_use.dart';
import 'package:my_app/refresh_indicator_page.dart';
import 'package:my_app/res_page.dart';
import 'package:my_app/shared_preference.dart';
import 'package:my_app/statefull_group_page.dart';
import 'package:my_app/statefull_layout_page.dart';

import 'animation_builder.dart';
import 'animation_page.dart';
import 'animation_widget.dart';
import 'app_lifecycle.dart';
import 'expansion_tile_page.dart';
import 'flutter_widget_lifecycle.dart';
import 'gesture_page.dart';
import 'gridview_page.dart';
import 'hero2.dart';
import 'hover_scrollview_page.dart';
import 'http_builder_page.dart';
import 'http_dart.dart';
import 'image_page.dart';
import 'lanuch_page.dart';
import 'less_group_page.dart';
import 'listview_page.dart';

void main() => runApp(DynamicTheme());

class DynamicTheme extends StatefulWidget {
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Brightness _brightness = Brightness.light;

  @override
  void initState() {
    hideScreen();
//    FlutterSplashScreen.hide();
    super.initState();
  }

  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
//          fontFamily: 'RubikMonoOne', //将字体运用到全局
          brightness: _brightness,
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('如何创建和使用Flutter的路由与导航')),
            body: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          if (_brightness == Brightness.dark) {
                            _brightness = Brightness.light;
                          } else {
                            _brightness = Brightness.dark;
                          }
                        });
                      },
                      child: Text(
                        '切换主题abc',
                        style: TextStyle(fontFamily: 'RubikMonoOne'),
                      ),
                    ),
                    RouteNavigator()
                  ],
                ),
              ],
            )),
        routes: <String, WidgetBuilder>{
          'plugin': (BuildContext context) => PluginUse(),
          'less': (BuildContext context) => LessGroupPage(),
          'ful': (BuildContext context) => StatefulGroup(),
          'layout': (BuildContext context) => FlutterLayoutGroup(),
          'gesture': (BuildContext context) => GesturePage(),
          'res': (BuildContext context) => ResPage(),
          'launch': (BuildContext context) => LaunchPage(),
          'widgetLifecycle': (BuildContext context) => WidgetLifecycle(),
          'appLifecycle': (BuildContext context) => AppLifecycle(),
          'photo': (BuildContext context) => PhotoApp(),
          'image': (BuildContext context) => ImagePage(),
          'animation': (BuildContext context) => AnimationPage(),
          'animation widget': (BuildContext context) => AnimationWidgetPage(),
          'animation builder': (BuildContext context) => AnimationBuilderPage(),
          'hero': (BuildContext context) => HeroAnimation(),
          'hero2': (BuildContext context) => RadialExpansionDemo(),
          'Http': (BuildContext context) => HttpPage(),
          'futurebuilder': (BuildContext context) => HttpBuilderPage(),
          'share preference': (BuildContext context) => SharedPreferencePage(),
          'listview': (BuildContext context) => ListViewPage(),
          'expansion tile': (BuildContext context) => ExpansionTilePage(),
          'gridview': (BuildContext context) => GridViewPage(),
          'refresh indicator': (BuildContext context) => RefreshIndicatorPage(),
          'hover scrollview': (BuildContext context) => HoverScrollViewPage(),
        });
  }
}

class RouteNavigator extends StatefulWidget {
  RouteNavigator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
              title: Text('${byName ? '' : '不'}通过路由名跳转'),
              value: byName,
              onChanged: (value) {
                setState(() {
                  byName = value;
                });
              }),
          _item('如何使用Flutter包和插件？', PluginUse(), 'plugin'),
          _item('StatelessWidget与基础组件', LessGroupPage(), 'less'),
          _item('StatefulWidget与基础组件', StatefulGroup(), 'ful'),
          _item('如何进行Flutter布局开发？', FlutterLayoutGroup(), 'layout'),
          _item('如何检测用户手势以及处理点击事件？', GesturePage(), 'gesture'),
          _item('如何导入和使用Flutter的资源文件？', ResPage(), 'res'),
          _item('如何打开第三方应用？', LaunchPage(), 'launch'),
          _item('Flutter页面生命周期', WidgetLifecycle(), 'widgetLifecycle'),
          _item('Flutter应用生命周期', AppLifecycle(), 'appLifecycle'),
          _item('【实战尝鲜】拍照APP开发', PhotoApp(), 'photo'),
          _item('图片控件开发', ImagePage(), 'image'),
          _item('动画Animation开发', AnimationPage(), 'animation'),
          _item(
              'AnimationWidget实现动画', AnimationWidgetPage(), 'animation widget'),
          _item('AnimationBuilder重构动画', AnimationBuilderPage(),
              'animation builder'),
          _item('hero创建动画', HeroAnimation(), 'hero'),
          _item('实现径向hero动画 高级', RadialExpansionDemo(), 'hero2'),
          _item('Http实现网络操作', HttpPage(), 'http'),
          _item('Future与FutureBuilder实用技巧', HttpBuilderPage(), 'futurebuilder'),
          _item('shared preference实现本地存储', SharedPreferencePage(),
              'share preference'),
          _item('listview列表使用', ListViewPage(), 'listview'),
          _item('expansion tile实现展开列表', ExpansionTilePage(), 'expansion tile'),
          _item('gridview网格布局使用', GridViewPage(), 'gridview'),
          _item('高级功能列表下拉刷新与上拉加载更多功能实现', RefreshIndicatorPage(),
              'refresh indicator'),
          _item('滑动悬停tabBar效果', HoverScrollViewPage(), 'hover scrollview'),
        ],
      ),
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
