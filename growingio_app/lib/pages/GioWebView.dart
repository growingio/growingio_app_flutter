import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';


class GioWebView extends StatelessWidget {
  WebViewController  ?_webViewController ;
  _loadHtmlFromAssets() async {

    String fileHtmlContents = await rootBundle.loadString('images/file/privacy.html');
    _webViewController!.loadUrl(Uri.dataFromString(fileHtmlContents,

        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
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
            initialUrl: '',

            javascriptMode: JavascriptMode.unrestricted,

            onWebViewCreated: (WebViewController webViewController) {

              _webViewController = webViewController;

              _loadHtmlFromAssets();

            },
          )
        ],
      ),
    );

  }

}
