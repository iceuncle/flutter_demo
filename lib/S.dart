import 'dart:ui';

class S {
  /// 设计稿标准 1080 x 1920 像素
  double _normalWidth = 360;
  double _normalHeight = 640;
  double _normalRatio = 3;

  // 是否以宽度为适配标准
  bool isBasedInWidth = true;

  // 真实设备和设计稿标准的换算比例
  double screenWidthRatio;
  double screenHeightRatio;

  // 设备像素比
  double _devicePixelRatio;

  static S instance;

  static init() {
    if (instance == null) instance = new S();
    instance.screenWidthRatio = window.physicalSize.width /
        (instance._normalWidth * instance._normalRatio);
    instance.screenHeightRatio = window.physicalSize.height /
        (instance._normalHeight * instance._normalRatio);
    instance._devicePixelRatio = window.devicePixelRatio;
  }

  static double px(double number) {
    return instance._px(number);
  }

  double _px(double number) {
    double results = 0.0;
    if (isBasedInWidth == true) {
      results = (number * _normalRatio) * screenWidthRatio / _devicePixelRatio;
      print('传入的像素为：$number，转换后的逻辑像素为：$results');
      return results;
    } else {
      results = (number * _normalRatio) * screenHeightRatio / _devicePixelRatio;
      print('传入的像素为：$number，转换后的逻辑像素为：$results');
      return results;
    }
  }
}
