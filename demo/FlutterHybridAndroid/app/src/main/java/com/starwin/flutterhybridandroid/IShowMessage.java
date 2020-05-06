package com.starwin.flutterhybridandroid;

/**
 * 界面描述：
 * <p>
 * Created by tianyang on 2020/5/6.
 */
public interface IShowMessage {
    void onShowMessage(String message);

    void sendMessage(String message, boolean useEventChannel);
}
