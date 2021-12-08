import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../util/RealTimePageData.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:async';

class RealtTimePage extends StatefulWidget {
  @override
  _RealtTimePage createState() => new _RealtTimePage();
}

/// Sample time series data type.
class LinearSales {
  final String  x;
  final num  y;
  LinearSales(this.x, this.y);
}

class TimeSeriesSales {
  final num time;
  final num sales;
  TimeSeriesSales(this.time, this.sales);
}
class _RealtTimePage extends State<RealtTimePage> {
  List colortype = [charts.MaterialPalette.blue.shadeDefault,charts.MaterialPalette.green.shadeDefault,charts.MaterialPalette.yellow.shadeDefault,charts.MaterialPalette.red.shadeDefault,charts.MaterialPalette.deepOrange.shadeDefault];
  List namearr = [];
  List nativecolortype = [Colors.blue,Colors.green,Colors.yellow,Colors.red,Colors.deepOrange];
  String gettimeStampWithTime(String timeStampString){
    DateTime today =DateTime.fromMillisecondsSinceEpoch(int.parse(timeStampString));
    return "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
  }
  String getTime(){
    var today = new DateTime.now();
    return "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
  }
  String getRealTime(){
    var today = new DateTime.now();
    return "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}-${today.hour.toString().padLeft(2,'0')}-${today.minute.toString().padLeft(2,'0')}";
  }
  Widget getChartView(int index){
    List arr = RealTimePageData.chartdata[index]['data'];
    List<TimeSeriesSales> data1 = [];
    List<TimeSeriesSales> data2 = [];
    int datatime = 0;
    for(int i = 0;i<arr.length/2;i+=(arr.length/2/24).toInt()){
      data1.add(TimeSeriesSales(datatime++, arr[i][1]));
    }
    datatime = 0;
    for(int i = (arr.length/2).toInt();i<arr.length;i+=(arr.length/2/24).toInt()){
      data2.add(TimeSeriesSales(datatime++, arr[i][1]));//
    }
    final List<charts.Series<TimeSeriesSales, num>> seriesList =[
      charts.Series<TimeSeriesSales, num>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.sales,
      // dashPatternFn: (_, __) => [8, 2, 4, 2],
      // displayName: 'wen',
      data: data1,
    ),
      charts.Series<TimeSeriesSales, num>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        // dashPatternFn: (_, __) => [8, 2, 4, 2],
        // displayName: 'wen',
        data: data2,
      )
    ];

    return charts.LineChart(List.from(seriesList),
        animate: true,
        defaultRenderer:
        charts.LineRendererConfig(
          // 圆点大小
          radiusPx: 5.0,
          stacked: false,
          // 线的宽度
          strokeWidthPx: 2.0,
          // 是否显示线
          includeLine: true,
          // 是否显示圆点
          includePoints: true,
          // 是否显示包含区域
          includeArea: true,
          // 区域颜色透明度 0.0-1.0
          areaOpacity: 0.2 ,
        ));
  }
  Widget getChartViews(int index ){
    final List<charts.Series<TimeSeriesSales, num>> seriesList = [];
    List arr = RealTimePageData.chartdata[index]["data"];
    namearr = [];
    namearr.add(arr[0][1]);
    for(int i = 1;i<arr.length;i++){
      if(!(arr[i][1] == arr[i-1][1])){
        namearr.add(arr[i][1]);
      }
    }

    for(int i = 0;i < namearr.length;i++){
      int datatime = 0;
      List<TimeSeriesSales> data = [];
      for(int  j = i*(arr.length/namearr.length).toInt();j<(i+1)*(arr.length/namearr.length);j+=((arr.length/namearr.length)/24).toInt()){
        data.add(TimeSeriesSales(datatime++, arr[j][2]));
    }
      seriesList.add(charts.Series<TimeSeriesSales, num>(
        id: 'Sales',
        colorFn: (_, __) => colortype[i],
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        // dashPatternFn: (_, __) => [8, 2, 4, 2],
        // displayName: 'wen',
        data: data,
      ));
    }
    return charts.LineChart(List.from(seriesList),
        animate: true,
        // selectionModels: [
        //   charts.SelectionModelConfig(
        //     type: charts.SelectionModelType.info,
        //     //切换选中数据时的回调函数
        //     changedListener: _onSelectionChange,
        //   ),
        // ],
        defaultRenderer:
        charts.LineRendererConfig(
          // 圆点大小
          radiusPx: 5.0,
          stacked: false,
          // 线的宽度
          strokeWidthPx: 2.0,
          // 是否显示线
          includeLine: true,
          // 是否显示圆点
          includePoints: true,
          // 是否显示包含区域
          includeArea: true,
          // 区域颜色透明度 0.0-1.0
          areaOpacity: 0.2 ,
        ));
  }
  Widget getChartViews1(int index ){
    int n = RealTimePageData.chartdata[index]["data"][0][0];
    List<LinearSales> num = [];
    num.add(LinearSales("此时", n));
    var seriesList =[charts.Series<LinearSales, String>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.x,
      measureFn: (LinearSales sales, _) => sales.y,
      dashPatternFn: (_, __) => [8, 2, 4, 2],
      displayName: 'wen',
      data: num,
    )
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
    );

  }
  Widget _simpleLine(int index) {
    print("chartdata[index]['data'][0]${RealTimePageData.chartdata[index]['data'][0]}");
    List value = RealTimePageData.chartdata[index]['data'][0];
    if(value.length == 2){
      print('getChartView');
      return  getChartView(index);
    }
    else if(value.length == 3){
      print('getChartView');
      return  getChartViews(index);
    }
    else{
      return getChartViews1(index);
    }
  }
  void initState() {
    super.initState();
    RealTimePageData.updata1 = (){
      setState(() {

      });
    };
  }
  List<Widget> _getLineName(){
    List<Widget> lview = [];
    for(int i = 0;i<namearr.length;i++){
      lview.add(SizedBox(height: 10.0,),);
      lview.add(Container(
        width: 8.0,
        height: 8.0,
        color: nativecolortype[i],
      ),);
      lview.add(Text(namearr[i]),);
      lview.add(SizedBox(height: 20.0,),);
    }
    return lview;
  }
  List<Widget> _getwidgget(List arr,String name,int index){
    List<Widget> lview = [];
    lview.add(SizedBox(height: 20,));
    lview.add(Text(
      name,//SummaryPageData.chartdata[i]['meta']['columns'][1]['name'],
      style: TextStyle(
          fontWeight: FontWeight.bold
      ),
    ));
    lview.add(SizedBox(height: 5,));
    lview.add(Text(
      getRealTime(),//SummaryPageData.chartdata[i]['meta']['columns'][1]['name'],
      style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold
      ),
    ));
    lview.add(Expanded(
        child: _simpleLine(index)
    ));
    lview.add(SizedBox(height: 5,));
    List value = RealTimePageData.chartdata[index]['data'][0];
    if(value.length == 2){
      lview.add(Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 2.0,
                color: Colors.blue,
              ),
              Text(gettimeStampWithTime(arr[0][0].toString())),//
              Container(
                width: 50.0,
                height: 2.0,
                color: Colors.green,
              ),
              Text(gettimeStampWithTime(arr[(arr.length-2).toInt()][0].toString())),//
            ],
          )

      ));
    }
    else if(value.length == 3){
      lview.add(Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getLineName()
          )

      ));
    }
    else{
      lview.add(Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                color: Colors.blue,
              ),
              Text(getTime()),
              SizedBox(height: 20.0,),
            ],
          )

      ));
    }
    return lview;

  }

  //自定义方法 私有方法 当前类可以使用 返回的是Widget组件
  List<Widget>  _listViewData(){
    List<Widget> list = [];

    for (int i = 0; i <  RealTimePageData.chartdata.length; i++) {
      List arr = RealTimePageData.chartdata[i]['data'];
      String name = RealTimePageData.chartkey[i];
      list.add(Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width+40,
          child:  Padding(
            padding: EdgeInsets.only(left: 1.0),
            child: Column(
               children: _getwidgget(arr,name,i)////<Widget>[<Widget>[
            ),
          )
      )
      );
    }
    return list;
  }
  void _refresh() async {
    RealTimePageData.realtime = [];
    RealTimePageData.realtimerequest = [];
    RealTimePageData.chartkey = [];
    RealTimePageData.chartdata = [];
    RealTimePageData.getrealtimeDashBoards();
    print("_refresh");
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: EasyRefresh(
        onRefresh: () async {
          _refresh();
        },
        // onLoad: () async {
        //   _load();
        // },
        child: ListView(
          // scrollDirection: Axis.vertical,
          children: this._listViewData(),
        )
      ),
    );
  }
}

