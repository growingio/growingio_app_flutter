import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'SetPage.dart';
import 'SummaryPage.dart';
import 'RealtTimePage.dart';
import 'SeeBoardPage.dart';
import '../widgets/MyDrawer.dart';
import 'NewsDetailPage.dart';
import '../util/SetpageData.dart';
import '../util/RealTimePageData.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyOSCClientState();
}

class MyOSCClientState extends State<RootPage> {
  // 页面底部当前tab索引值
  int _tabIndex = 0;
  // TabItem的文本默认样式
  final tabTextStyleNormal = TextStyle(color: const Color(0xff969696));
  // TabItem被选中时的文本样式
  final tabTextStyleSelected = TextStyle(color: const Color(0xff63ca6c));

  // 页面底部TabItem上的图标数组
  var tabImages;
  // 页面内容区域
  var _body;
  // 页面顶部的大标题
  var appBarTitles = ['概览', '实时', '看板', '设置'];

  Map<String, WidgetBuilder> _routes = new Map();

  // 传入图片路径，返回一个Image组件
  Image getTabImage(path) {
    return  Image.asset(path, width: 20.0, height: 20.0);
  }

  // 数据初始化，包括TabIcon数据和页面内容数据
  void initData() {
    SetPageData.pushSummaryPage = (){
      setState(() {
        _tabIndex = 0;
      });
    };
    _routes['newsDetail'] = (BuildContext) {
      return  NewsDetailPage();
    };
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/overview-inactive.png'),
          getTabImage('images/overview-active.png')
        ],
        [
          getTabImage('images/realtime-inactive.png'),
          getTabImage('images/realtime-active.png')
        ],
        [
          getTabImage('images/dashboard-inactive.png'),
          getTabImage('images/dashboard-active.png')
        ],
        [
          getTabImage('images/setting-inactive.png'),
          getTabImage('images/setting-active.png')
        ]
      ];
    }
    // IndexedStack是一个可以根据index来显示不同内容的组件，可以实现点击TabItem切换页面的功能
    _body =  IndexedStack(
      children: <Widget>[
        SummaryPage(),
        RealtTimePage(),
        SeeBoardPage(),
        SetPage()
      ],
      index: _tabIndex,
    );
  }

  // 根据索引值确定Tab是选中状态的样式还是非选中状态的样式
  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  // 根据索引值确定TabItem的icon是选中还是非选中
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  // 根据索引值返回页面顶部标题
  Text getTabTitle(int curIndex) {
    return  Text(
        appBarTitles[curIndex],
        style: getTabTextStyle(curIndex)
    );
  }

  List<BottomNavigationBarItem> getBottomNavItems() {
    List<BottomNavigationBarItem> list = [];//new List();
    for (int i = 0; i < 4; i++) {
      list.add(new BottomNavigationBarItem(
          icon: getTabIcon(i),
          title: getTabTitle(i)
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return  MaterialApp(
      theme:  ThemeData(
        // 设置页面的主题色
          primaryColor: const Color(0xFF63CA6C)
      ),
      routes: _routes,
      home: Scaffold(
        appBar:  AppBar(
          // 设置AppBar标题
            title:  Text(SetPageData.projectName,//appBarTitles[_tabIndex],
                // 设置AppBar上文本的样式
                style:  TextStyle(color: Colors.white)),
            // 设置AppBar上图标的样式
            iconTheme:  IconThemeData(color: Colors.white)
        ),
        body: _body,
        // bottomNavigationBar属性为页面底部添加导航的Tab，CupertinoTabBar是Flutter提供的一个iOS风格的底部导航栏组件
        bottomNavigationBar:  CupertinoTabBar(
          items: getBottomNavItems(),
          currentIndex: _tabIndex,
          onTap: (index) {
            // 底部TabItem的点击事件处理，点击时改变当前选择的Tab的索引值，则页面会自动刷新
            setState((){
              _tabIndex = index;
              if(_tabIndex == 1){
                RealTimePageData.getrealtimeDashBoards();
              }
            });
          },
        ),
        // // drawer属性用于为当前页面添加一个侧滑菜单
        drawer:  MyDrawer(),
      ),
    );
  }
}
