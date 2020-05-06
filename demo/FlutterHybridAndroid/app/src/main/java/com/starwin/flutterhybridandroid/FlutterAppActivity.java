package com.starwin.flutterhybridandroid;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;


/**
 * 界面描述：
 * <p>
 * Created by tianyang on 2020-05-06.
 */
public class FlutterAppActivity extends FlutterActivity {
    private static final String TAG = FlutterAppActivity.class.getSimpleName();

    public final static String INIT_PARAMS = "initParams";
    private String initParams;

    public static void start(Context context, String initParams) {
        Intent intent = new Intent(context, FlutterAppActivity.class);
        intent.putExtra(INIT_PARAMS, initParams);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initParams = getIntent().getStringExtra(INIT_PARAMS);
    }


    @NonNull
    @Override
    public String getInitialRoute() {
        return initParams == null ? super.getInitialRoute() : initParams;
    }

}
