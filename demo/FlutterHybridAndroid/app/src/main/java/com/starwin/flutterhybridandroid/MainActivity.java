package com.starwin.flutterhybridandroid;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.test).setOnClickListener(view -> {
//            startActivity(FlutterActivity
//                    .withNewEngine()
//                    .initialRoute("route1")
//                    .build(MainActivity.this));

            FlutterAppActivity.start(this, "route2");
        });
    }


}
