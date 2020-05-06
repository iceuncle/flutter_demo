package com.starwin.flutterhybridandroid;

import android.app.Activity;
import android.widget.Toast;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StringCodec;

/**
 * 界面描述：
 * BasicMessageChannel
 * 用于传递字符串和半结构化的信息，持续通信，如：Native将遍历到的文件信息陆续传递到Dart
 * 比如：Flutter将从服务端陆陆续获取到信息交个Native加工，Native处理完返回等
 *
 * 可以两边互相发送 dart发送消息给native并获取返回值  native发送消息给dart，并获取返回值
 * <p>
 * Created by tianyang on 2020/5/6.
 */
public class BasicMessageChannelPlugin implements BasicMessageChannel.MessageHandler<String>, BasicMessageChannel.Reply<String> {
    private final Activity activity;
    private final BasicMessageChannel<String> messageChannel;

    static BasicMessageChannelPlugin registerWith(BinaryMessenger messenger, Activity activity) {
        return new BasicMessageChannelPlugin(messenger, activity);
    }

    private BasicMessageChannelPlugin(BinaryMessenger messenger, Activity activity) {
        this.activity = activity;
        this.messageChannel = new BasicMessageChannel<>(messenger, "BasicMessageChannelPlugin", StringCodec.INSTANCE);
//        设置消息处理器，处理来自Dart的消息
        messageChannel.setMessageHandler(this);
    }

    @Override
    public void onMessage(String s, BasicMessageChannel.Reply<String> reply) {//处理Dart发来的消息
        reply.reply("BasicMessageChannel收到：" + s);//可以通过reply进行回复
        if (activity instanceof IShowMessage) {
            ((IShowMessage) activity).onShowMessage(s);
        }
        Toast.makeText(activity, s, Toast.LENGTH_SHORT).show();
    }

    /**
     * 向Dart发送消息，并接受Dart的反馈
     *
     * @param message  要给Dart发送的消息内容
     * @param callback 来自Dart的反馈
     */
    void send(String message, BasicMessageChannel.Reply<String> callback) {
        messageChannel.send(message, callback);
    }

    @Override
    public void reply(String s) {

    }
}
