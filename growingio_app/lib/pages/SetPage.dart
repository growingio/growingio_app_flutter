// pages/TweetsListPage.dart
import 'package:flutter/material.dart';
import 'RootPage.dart';
import '../util/SetpageData.dart';
import '../util/SummaryPageData.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}
class SetPage extends StatefulWidget {
  @override
  _SetPage createState() => new _SetPage();
}
class _SetPage extends State<SetPage> {
  //自定义方法 私有方法 当前类可以使用 返回的是Widget组件
  List<Widget>  _listViewData(){
    List<Widget> list = [];
    list.add(Container(
      height: 50.0,
      child:  Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Align(
          child: Text(
            '选择项目',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontSize: 22.0),
          ),
          alignment: Alignment.bottomLeft,
        ),
      )
    )
      );
    for (var i = 0; i <  SetPageData.project.length; i++) {
      list.add(
        FlatButton(
          //padding: EdgeInsets.only(left: 10.0),//左右填充24个像素块
          minWidth: 200.0,
          height: 47.0,
          onPressed: ()async{
            print('点击$i ${SetPageData.project[i]['name']}');
            SetPageData.projectName = SetPageData.project[i]['name'];
            SetPageData.projectid = SetPageData.project[i]['id'];
            SummaryPageData.chartdata = [];
            SummaryPageData.chartkey = [];
            SummaryPageData.getData();
            SetPageData.func = (){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>  RootPage()
                  ), (route) => route == null);
            };
          },
          color: Colors.white,//按钮颜色
          child: Container(
              child: Align(
                child: Text(SetPageData.project[i]['name'],
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.bottomLeft,
              ),
          )
        ),
      );
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      // scrollDirection: Axis.vertical,
      children: this._listViewData(),
    );
  }
}
