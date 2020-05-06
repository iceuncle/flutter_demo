package com.starwin.flutterhybridandroid;

import android.os.Bundle;
import android.widget.EditText;
import android.widget.LinearLayout;

import androidx.appcompat.app.AppCompatActivity;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.JSONMethodCodec;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformPlugin;

public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final EditText paramInput = findViewById(R.id.paramInput);

        findViewById(R.id.test).setOnClickListener(view -> {
//            startActivity(FlutterActivity
//                    .withNewEngine()
//                    .initialRoute("route1")
//                    .build(MainActivity.this));

            String inputParams = paramInput.getText().toString().trim();
            FlutterAppActivity.start(this, inputParams);
        });
    }


}
