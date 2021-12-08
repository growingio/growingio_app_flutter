
import 'package:flutter/material.dart';
import '../pages/LoginPage.dart';

import '../util/SetpageData.dart';
class MyDrawer extends StatelessWidget {
  // 菜单文本前面的图标大小
  static const double IMAGE_ICON_WIDTH = 30.0;
  // 菜单后面的箭头的图标大小
  static const double ARROW_ICON_WIDTH = 16.0;
  // 菜单后面的箭头图片
  var rightArrowIcon =  Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );
  // 菜单的文本
  List menuTitles = SetPageData.userInfo;

  TextStyle menuStyle = new TextStyle(
    fontSize: 15.0,
  );
  @override
  Widget build(BuildContext context) {
    final logo = Hero(//飞行动画
      tag: 'hero',
      child: CircleAvatar(//圆形图片组件
        backgroundColor: Colors.transparent,//透明
        radius: 48.0,//半径
        child: Image.asset("images/logo.png"),//图片
      ),
    );
    var img =  Image.asset(
      'images/cover_img.jpg',
      width: 150.0,
      height: 150.0,
    );

    final name = Text(
      menuTitles[0],
      //textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 20.0),
    );
    final email = Text(
      menuTitles[1],
      //textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 20.0),
    );
    final company = Text(
      menuTitles[2],
      //textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 20.0),
    );
    final mobile = Text(
      menuTitles[3],
      //textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 20.0,),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),//上下各添加16像素补白
      child: Material(
        borderRadius: BorderRadius.circular(30.0),// 圆角度
        shadowColor: Colors.lightBlueAccent.shade100,//阴影颜色
        elevation: 5.0,//浮动的距离
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new LoginPage()
                ), (route) => route == null);
          },
          color: Colors.green,//按钮颜色
          child: Text('退 出 登 录', style: TextStyle(color: Colors.white, fontSize: 20.0),),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        // 设置AppBar标题
          title: Text('我 的',
              // 设置AppBar上文本的样式
              style: new TextStyle(color: Colors.white)),
          // 设置AppBar上图标的样式
          iconTheme: new IconThemeData(color: Colors.white)
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(//将这些组件全部放置在ListView中
          shrinkWrap: true,//内容适配
          padding: EdgeInsets.only(left: 24.0, right: 24.0),//左右填充24个像素块
          children: <Widget>[
            img,
            SizedBox(height: 24.0,),
            name,
            SizedBox(height: 24.0,),//用来设置两个控件之间的间距
            email,
            SizedBox(height: 24.0,),
            company,
            SizedBox(height: 24.0,),
            mobile,
            SizedBox(height: 48.0,),
            loginButton
          ],
        ),
      ),
    );
  }
}
