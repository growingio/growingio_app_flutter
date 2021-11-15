import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../util/SummaryPageData.dart';
import '../util/SetpageData.dart';
class SeeBoardPage extends StatefulWidget {
  @override
  _SeeBoardPage createState() => new _SeeBoardPage();
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
class _SeeBoardPage extends State<SeeBoardPage> {
  String gettimeStampWithTime(String timeStampString){
    // var strtime =
    // DateTime.fromMillisecondsSinceEpoch(int.parse(timeStampString));
    // print('$strtime');

    return timeStampString;
  }
  Widget getChartView(int index){
    String str;
    if(SummaryPageData.plat.length == 2){
      str = "平台in 移动应用";
    }else{
      str = "平台in "+SummaryPageData.plat[0];
    }

    List arr = SummaryPageData.chartdata[index]['data'];
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
    // return charts.TimeSeriesChart(
    //     seriesList
    // );
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
    String str;
    if(SummaryPageData.plat.length == 2){
      str = "平台in 移动应用";
    }else{
      str = "平台in "+SummaryPageData.plat[0];
    }
    List num = SummaryPageData.chartdata[index]['data'];
    List<LinearSales> data1 = [];
    for(int i = 0;i<num.length;i++){
      print('${num[i][0]}${num[i][1]}');
      data1.add(LinearSales(num[i][0], (num[i][1])));
    }

    var seriesList =[charts.Series<LinearSales, String>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.x,
      measureFn: (LinearSales sales, _) => sales.y,
      dashPatternFn: (_, __) => [8, 2, 4, 2],
      displayName: 'wen',
      data: data1,
    )
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
    );

  }
  Widget _simpleLine(int index) {
    print('${SummaryPageData.chartdata}');
    List value = SummaryPageData.chartdata[index]['data'];
    print('$value');
    if(value.length > 20){
      print('getChartView');
      return  getChartView(index);
    }else{
      print('getChartView');
      return  getChartViews(index);
    }
  }
  void initState() {
    super.initState();
    SetPageData.updata = (){
      setState(() {

      });
    };
  }  //自定义方法 私有方法 当前类可以使用 返回的是Widget组件
  List<Widget>  _listViewData(){
    List<Widget> list = [];
    String str;
    if(SummaryPageData.plat.length == 2){
      str = "   in 移动应用";
    }else{
      str = "   in "+SummaryPageData.plat[0];
    }

    for (int i = 0; i <  SummaryPageData.chartdata.length; i++) {
      List arr = SummaryPageData.chartdata[i]['data'];
      String name = SummaryPageData.chartkey[i];
      list.add(Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width+40,
          child:  Padding(
            padding: EdgeInsets.only(left: 1.0),
            child: Column(
              children: <Widget>[
                Text(
                  name+str,//SummaryPageData.chartdata[i]['meta']['columns'][1]['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                //SizedBox(height: 5,),
                Expanded(
                    child: _simpleLine(i)
                ),
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 2.0,
                          color: Colors.blue,
                        ),
                        Text('2021-11-09'),//gettimeStampWithTime(arr[0][0].toString())
                        SizedBox(width: 10.0,),
                        Container(
                          width: 50.0,
                          height: 2.0,
                          color: Colors.green,
                        ),
                        Text('2021-11-01')//gettimeStampWithTime(arr[arr.length-2][0].toString())
                      ],
                    )

                ),
              ],
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
