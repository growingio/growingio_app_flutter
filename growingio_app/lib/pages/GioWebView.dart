import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GioWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 设置AppBar标题
          title: Text('隐私协议',
              // 设置AppBar上文本的样式
              style: new TextStyle(color: Colors.white)),
          // 设置AppBar上图标的样式
          iconTheme: new IconThemeData(color: Colors.white)
      ),
      body: Stack(
        children: <Widget>[
          new WebView(
            initialUrl: 'https://accounts.growingio.com/privacy', // 加载的url

          )
        ],
      ),
    );
  }
}
