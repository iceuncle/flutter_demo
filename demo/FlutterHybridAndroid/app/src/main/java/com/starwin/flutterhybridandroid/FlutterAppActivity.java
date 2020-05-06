package com.starwin.flutterhybridandroid;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;


/**
 * 界面描述：
 * <p>
 * Created by tianyang on 2020-05-06.
 */
public class FlutterAppActivity extends FlutterActivity implements IShowMessage {
    private static final String TAG = FlutterAppActivity.class.getSimpleName();

    public final static String INIT_PARAMS = "initParams";
    private String initParams;
    private UIPresenter uiPresenter;
    private EventChannelPlugin eventChannelPlugin;
    private BasicMessageChannelPlugin basicMessageChannelPlugin;


    public static void start(Context context, String initParams) {
        Intent intent = new Intent(context, FlutterAppActivity.class);
        intent.putExtra(INIT_PARAMS, initParams);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initParams = getIntent().getStringExtra(INIT_PARAMS);
        if (getFlutterEngine() != null) {
            eventChannelPlugin = EventChannelPlugin.registerWith(getFlutterEngine().getDartExecutor());
            MethodChannelPlugin.registerWith(getFlutterEngine().getDartExecutor(), this);
            basicMessageChannelPlugin = BasicMessageChannelPlugin.registerWith(getFlutterEngine().getDartExecutor(), this);
            uiPresenter = new UIPresenter(this, "通信与混合开发", this);
        } else {
            Log.e(TAG, "getFlutterEngine() is null register plugin fail");
        }

    }


    @NonNull
    @Override
    public String getInitialRoute() {
        return initParams == null ? super.getInitialRoute() : initParams;
    }

    @Override
    public void onShowMessage(String message) {
        uiPresenter.showDartMessage(message);
    }

    @Override
    public void sendMessage(String message, boolean useEventChannel) {
        if (useEventChannel) {
            eventChannelPlugin.send(message);
        } else {
            basicMessageChannelPlugin.send(message, this::onShowMessage);
        }
    }


}
