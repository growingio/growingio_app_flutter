package com.growingio.gross;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.os.StrictMode;


import com.growingio.android.sdk.autotrack.GrowingAutotracker;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        //startActivity(FlutterActivity.createDefaultIntent(this));
////        startActivity(FlutterActivity.
////                withCachedEngine("engine_id").
////                build(MainActivity.this));
//        MyFlutterPlugin.registerWith((PluginRegistry) this);
//
//    }
    private static final String channel = "setDataCollectionEnabled";

    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),channel).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        if (methodCall.method!=null) {
                            result.success(toJava(methodCall.method));
                        } else {
                            result.notImplemented();
                        }
                    }
                }
        );
    }


    public String toJava(String name){
        Boolean flag = Boolean.FALSE;
        if(name == "true"){
            flag=Boolean.TRUE;
        }
        GrowingAutotracker.get().setDataCollectionEnabled(flag);
        return "setDataCollectionEnabled name success";
    }


}

