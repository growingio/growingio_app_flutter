import 'dart:convert';

import 'package:flutter/material.dart';
import 'RootPage.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/NetUtils.dart';
import 'GioWebView.dart';
import '../util/SetpageData.dart';
//登录界面
class LoginPage extends StatefulWidget {

  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool flag = false;
  final _userName = TextEditingController(); //用户名
  final _userPwd = TextEditingController(); //密码
  //GlobalKey _globalKey = new GlobalKey<FormState>(); //用于检查输入框是否为空
  // 保存账号密码
  void _saveLoginMsg() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("name", _userName.text);
    preferences.setString("pwd", _userPwd.text);
  }
  //读取账号密码，并将值直接赋给账号框和密码框
  void _getLoginMsg()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.get("name") != null && preferences.get("pwd") != null){
      _userName.text=preferences.get("name").toString();
      _userPwd.text=preferences.get("pwd").toString();
    }
  }
  @override
  void initState(){
    super.initState();
    _getLoginMsg();
  }

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

    final email = TextFormField(//用户名
      controller: _userName,
      decoration: InputDecoration(
          hintText: '请输入用户名',//提示内容Wen0219gro
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),//上下左右边距设置
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)//设置圆角大小
          )
      ),
    );

    final password = TextFormField(//密码
      controller: _userPwd,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '请输入密码',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
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
          onPressed: ()async{
            if(_userName.text == ''||_userPwd.text == ''){
              print('user_name:$_userName.text  user_pw:$_userPwd.text');
              Toast.show('账号密码有误或者网络连接失败', context);
              return;
            }
            if(flag){
              //获取登录token
              dynamic body = await NetUtils.post("https://www.growingio.com/oauth2/token", params: {
                "username": _userName.text,
                "password": _userPwd.text,
                "grantType":"password"
              });
               if(body == null){
                 print('请求失败');
                 Toast.show('账号密码有误或者网络连接失败', context);
                 return ;
               }
               Map<String, dynamic> response = jsonDecode(body.toString());
               SetPageData.token = response['token'];
               SetPageData.getUserInfoRequest();
               SetPageData.getProject();
              _saveLoginMsg();//
              Navigator.of(context).pushAndRemoveUntil(
                        new MaterialPageRoute(builder: (context) => new RootPage()
                        ), (route) => route == null);
            }else{
              Toast.show('请阅读并同意隐私协议', context);
            }
          },
          color: Colors.green,//按钮颜色
          child: Text('登 录', style: TextStyle(color: Colors.white, fontSize: 20.0),),
        ),
      ),
    );
    final forgotLabel=  Row(
      children: <Widget>[
        // 菜单item的图标
        getIconImage(),

         Expanded(
            child: FlatButton(//扁平化的按钮，前面博主已经讲解过
              child: Text('我已阅读并同意《用户协议》 《隐私政策》', style: TextStyle(color: Colors.black54, fontSize: 12.0),),
              onPressed: () {
                Navigator.push(
                    context,
                     MaterialPageRoute(builder: (context) =>  GioWebView()));
              },
            )
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(//将这些组件全部放置在ListView中
          shrinkWrap: true,//内容适配
          padding: EdgeInsets.only(left: 24.0, right: 24.0),//左右填充24个像素块
          children: <Widget>[
            logo,
            SizedBox(height: 96.0,),//用来设置两个控件之间的间距
            email,
            SizedBox(height: 8.0,),
            password,
            SizedBox(height: 72.0,),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
  Widget getIconImage() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 6.0, 0.0),
      child: IconButton(
        icon: flag?ImageIcon(AssetImage('images/选中.png')):ImageIcon(AssetImage('images/未选中.png')),//ImageIcon(AssetImage(path)),
        //tooltip: 'click IconButton',
        onPressed: () {
          setState(() {
            if(flag){
              flag = false;
            }else{
              flag = true;
            }
          });
        },
      ),
       //,Icons.wifi
    );
  }
}
