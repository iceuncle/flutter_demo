import 'package:flutter/material.dart';

//AnimationWidget实现动画
class AnimationWidgetPage extends StatefulWidget {
  @override
  _AnimationWidgetPageState createState() => _AnimationWidgetPageState();
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class _AnimationWidgetPageState extends State<AnimationWidgetPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationWidget实现动画'),
      ),
      body: Center(
        child: AnimatedLogo(animation: animation,),
      ),
    );
  }
}
