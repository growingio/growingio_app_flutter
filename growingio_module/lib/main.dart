import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/LoginPage.dart';



void main() {
  runApp(MyApp());
}

// MyApp是一个有状态的组件，因为页面标题，页面标题，页面底部Tab都会改变
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyOSCClientState();
}

class MyOSCClientState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:  ThemeData(
        // 设置页面的主题色
          primaryColor: const Color(0xFF63CA6C)
      ),
       home: LoginPage()
    );


  }
}
