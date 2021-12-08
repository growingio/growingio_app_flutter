
package com.growingio.gross;
import android.app.Application;

import com.growingio.android.sdk.autotrack.CdpAutotrackConfiguration;
import com.growingio.android.sdk.autotrack.GrowingAutotracker;
import com.growingio.giokit.GioKit;

//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.embedding.engine.FlutterEngineCache;
//import io.flutter.embedding.engine.dart.DartExecutor;


public class MyApplication extends Application {
    //private FlutterEngine fe;


    @Override
    public void onCreate() {
        super.onCreate();
        // Config GrowingIO
        // 参数需要从CDP增长平台上，创建新应用，或从已知应用中获取, 如不清楚请联系您的专属项目经理
        // YourAccountId eg: 0a1b4118dd954ec3bcc69da5138bdb96
        // Your URLScheme eg: growing.xxxxxxxxxxx
        // YourServerHost eg: https://api.growingio.com 需要填写完整的url地址
        // YourDatasourceId eg: 11223344aabbcc
        CdpAutotrackConfiguration sConfiguration = new CdpAutotrackConfiguration("91eaf9b283361032", "growing.812112b7b4c20158")
                .setDataCollectionServerHost("http://uat-api.growingio.com")
                .setDebugEnabled(true)
                .setDataCollectionEnabled(false)
                .setDataSourceId("bc955bbbd5157cbe");
        GrowingAutotracker.startWithConfiguration(this,sConfiguration);
        GioKit.with(this).build();
//        //Flutter引擎
//        fe = new FlutterEngine(this);
//        fe.getNavigationChannel().setInitialRoute("image_page");
//        //通过engine_id唯一标识来缓存
//        fe.getDartExecutor().executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault());
//        FlutterEngineCache
//                .getInstance()
//                .put("engine_id", fe);

    }
    /**
     * onTerminate()当App销毁时执行
     */
//    @Override
//    public void onTerminate() {
//        //销毁flutter引擎
//        fe.destroy();
//        super.onTerminate();
//    }

}