import 'dart:ui';

var S = new Screen();

///屏幕适配类
class Screen {
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

  Screen._internal() {
    screenWidthRatio =
        window.physicalSize.width / (_normalWidth * _normalRatio);
    screenHeightRatio =
        window.physicalSize.height / (_normalHeight * _normalRatio);
    _devicePixelRatio = window.devicePixelRatio;
  }

  static Screen _singleton = new Screen._internal();

  factory Screen() => _singleton;

  double px(double number) {
    return _singleton._px(number);
  }

  _px(double number) {
    double results = 0.0;
    if (isBasedInWidth == true) {
      results = (number * _normalRatio) * screenWidthRatio / _devicePixelRatio;
      return results;
    } else {
      results = (number * _normalRatio) * screenHeightRatio / _devicePixelRatio;
      return results;
    }
  }
}
