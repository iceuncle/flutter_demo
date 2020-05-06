package com.starwin.flutterhybridandroid;

import android.app.Activity;
import android.util.Log;
import android.widget.Toast;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * 界面描述：
 * MethodChannelPlugin
 * 用于传递方法调用（method invocation），一次性通信，通常用于Dart调用Native的方法：如拍照；
 *
 * 可以获取dart调用的方法，并返回值
 * <p>
 * Created by tianyang on 2020/5/6.
 */
public class MethodChannelPlugin implements MethodCallHandler {
    private final Activity activity;

    /**
     * Plugin registration.
     */
    public static void registerWith(BinaryMessenger messenger, Activity activity) {
        MethodChannel channel = new MethodChannel(messenger, "MethodChannelPlugin");
        MethodChannelPlugin instance = new MethodChannelPlugin(activity);
        channel.setMethodCallHandler(instance);
    }

    private MethodChannelPlugin(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {//处理来自Dart的方法调用
            case "send":
                showMessage(call.arguments());
                result.success("MethodChannelPlugin收到：" + call.arguments);//返回结果给Dart
                break;
            default:
                result.notImplemented();
        }
    }

    /**
     * 展示来自Dart的数据
     *
     * @param arguments
     */
    private void showMessage(String arguments) {
        if (activity instanceof IShowMessage) {
            ((IShowMessage) activity).onShowMessage(arguments);
        }
        Toast.makeText(activity, arguments, Toast.LENGTH_SHORT).show();
    }
}
