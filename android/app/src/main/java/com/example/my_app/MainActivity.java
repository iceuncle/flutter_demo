package com.example.my_app;

import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;

import org.devio.flutter.splashscreen.SplashScreen;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * 界面描述：
 * <p>
 * Created by tianyang on 2020/5/6.
 */
public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        SplashScreen.show(this, true);
        super.onCreate(savedInstanceState);
    }

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
