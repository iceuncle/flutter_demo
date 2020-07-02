import 'dart:ui';

var S = new Screen();

///屏幕适配类
class Screen {
  /// 设计稿标准 1080 x 1920 像素
  double _normalWidth = 1080;
  double _normalHeight = 640;
  double _normalRatio = 3;

  /// 设备像素比
  double _devicePixelRatio;

  ///输出比例
  double scale;

  Screen._internal() {
    _devicePixelRatio = window.devicePixelRatio;
    scale = (window.physicalSize.width / _devicePixelRatio) /
        (_normalWidth / _normalRatio);

    print('window.physicalSize.width: ${window.physicalSize.width}');
    print('window.physicalSize.height: ${window.physicalSize.height}');
    print('window.devicePixelRatio: ${window.devicePixelRatio}');
    print('scale: $scale');
  }

  static Screen _singleton = new Screen._internal();

  factory Screen() => _singleton;

  double dp(double number) {
    return _singleton._dp(number);
  }

  _dp(double number) {
    return number * scale;
  }
}
