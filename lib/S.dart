import 'dart:ui';

class S {
  /// 设计稿标准 1080 x 1920 像素
  static double _normalWidth = 360;
  static double _normalHeight = 640;
  static double _normalRatio = 3;

  // 是否以宽度为适配标准
  static bool isBasedInWidth = true;

  // 真实设备和设计稿标准的换算比例
  static double screenWidthRatio;
  static double screenHeightRatio;

  // 设备像素比
  static double _devicePixelRatio;

  static init() {
    screenWidthRatio =
        window.physicalSize.width / (_normalWidth * _normalRatio);
    screenHeightRatio =
        window.physicalSize.height / (_normalHeight * _normalRatio);
    _devicePixelRatio = window.devicePixelRatio;
  }

  static double px(double number) {
    double results = 0.0;
    if (isBasedInWidth == true) {
      results =
          (number * _normalRatio) * screenWidthRatio / _devicePixelRatio;
      print('传入的像素为：$number，转换后的逻辑像素为：$results');
      return results;
    } else {
      results = (number * _normalRatio) *
          screenHeightRatio /
          _devicePixelRatio;
      print('传入的像素为：$number，转换后的逻辑像素为：$results');
      return results;
    }
  }
}
