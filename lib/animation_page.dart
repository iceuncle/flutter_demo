import 'package:flutter/material.dart';

//动画Animation开发
class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          animationStatus = status;
        });
      });
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
        title: Text('动画Animation开发'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
            GestureDetector(
              onTap: () {
                controller.reset();
                controller.forward();
              },
              child: Text(
                'Start',
                textDirection: TextDirection.ltr,
              ),
            ),
            Text('State:' + animationStatus.toString()),
            Text('Value:' + animationValue.toString()),
            Container(
                height: animation.value,
                width: animation.value,
                child: FlutterLogo()),
          ],
        ),
      ),
    );
  }
}
