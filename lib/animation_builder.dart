import 'package:flutter/material.dart';

//AnimationBuilder重构动画
class AnimationBuilderPage extends StatefulWidget {
  @override
  _AnimationBuilderPageState createState() => _AnimationBuilderPageState();
}

class LogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        height: animation.value,
        width: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}

class _AnimationBuilderPageState extends State<AnimationBuilderPage>
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
        title: Text('AnimationBuilder重构动画'),
      ),
      body: Center(
        child: GrowTransition(
          animation: animation,
          child: LogWidget(),
        ),
      ),
    );
  }
}
