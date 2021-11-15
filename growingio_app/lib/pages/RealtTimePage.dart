import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../util/RealTimePageData.dart';

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
    final List<charts.Series<TimeSeriesSales, num>> seriesList =[charts.Series<TimeSeriesSales, num>(
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
    List namearr = [];
   List arr = RealTimePageData.chartdata[index]["data"];
    namearr.add(arr[0][1]);
    for(int i = 1;i<arr.length;i++){
      if(!(arr[i][1] == arr[i-1][1])){
        namearr.add(arr[i][1]);
      }
    }
    for(int i = 0;i < namearr.length;i++){
      int datatime = 0;
      List<TimeSeriesSales> data = [];
      for(int  i = 0+index*(arr.length/namearr.length).toInt();i<(arr.length/namearr.length);i+=((arr.length/namearr.length)/24).toInt()){
        data.add(TimeSeriesSales(datatime++, arr[i][2]));
    }
      seriesList.add(charts.Series<TimeSeriesSales, num>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        // dashPatternFn: (_, __) => [8, 2, 4, 2],
        // displayName: 'wen',
        data: data,
      ));
    }
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
    //RealTimePageData.getrealtimeDashBoards();
    RealTimePageData.updata1 = (){
      setState(() {

      });
    };
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
          fontSize: 15,
          fontWeight: FontWeight.bold
      ),
    ));
    lview.add(Expanded(
        child: _simpleLine(index)
    ));
    lview.add(SizedBox(height: 5,));
    if(arr.length > 20){
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
              //   Text(
              //     name,
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold
              //     ),
              //   ),
              //   Text(
              //     "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}-${today.hour.toString().padLeft(2,'0')}-${today.minute.toString().padLeft(2,'0')}",
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold
              //     ),
              //   ),
              //   //SizedBox(height: 5,),
              //   Expanded(
              //       child: _simpleLine(i)
              //   ),
              //   Center(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Container(
              //             width: 50.0,
              //             height: 2.0,
              //             color: Colors.blue,
              //           ),
              //           Text('2021-11-09'),//gettimeStampWithTime(arr[0][0].toString())
              //           SizedBox(width: 10.0,),
              //           Container(
              //             width: 50.0,
              //             height: 2.0,
              //             color: Colors.green,
              //           ),
              //           Text('2021-11-01')//gettimeStampWithTime(arr[arr.length-2][0].toString())
              //         ],
              //       )
              //
              //   ),
              // ],
            ),
          )
      )
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
