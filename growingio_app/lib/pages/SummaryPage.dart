import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../util/SummaryPageData.dart';
import '../util/SetpageData.dart';
class SummaryPage extends StatefulWidget {
  @override
  _SummaryPage createState() => new _SummaryPage();
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
class _SummaryPage extends State<SummaryPage> {

  String gettimeStampWithTime(String timeStampString){
    DateTime today =DateTime.fromMillisecondsSinceEpoch(int.parse(timeStampString));
    return "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
  }
  String getTime(){
    var today = new DateTime.now();
    today.add(new Duration(days: -1));
    return "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
  }
  int _currentIndex = 0;

  Widget _buildCupertinoSegmentedControl() {
    return CupertinoSegmentedControl<int>(
      //子标签
      children: <int, Widget>{
        0: Text("移动应用"),
        1: Text("Web"),
        2: Text("iOS"),
        3: Text("Android "),
      },
      //当前选中的索引
      groupValue: _currentIndex,
      //点击回调
      onValueChanged: (int index) {
        setState(() {
          _currentIndex = index;
          switch (index) {
            case 0:
            //
              SummaryPageData.plat = ["iOS", "Android"];
              break;
              case 1:
                SummaryPageData.plat = ["Web"];
              break;
              case 2: //
              SummaryPageData.plat = ["iOS"];
             break;
             case 3:
            //
            SummaryPageData.plat = ["Android"];
             break;
            default:
            break;
        }
          SummaryPageData.chartdata = [];
          SummaryPageData.chartkey = [];
          SummaryPageData.refreshBody();
        });
      },
      //选中的背景颜色
      selectedColor: Colors.blue,
      //未选中的背景颜色
      unselectedColor: Colors.white,
      //边框颜色
      borderColor: Colors.blue,
      //按下的颜色
      pressedColor: Colors.blue.withOpacity(0.4),
    );
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
  List<Widget> _getwidgget(List arr,String name,String str,int index){
    List<Widget> lview = [];
    lview.add(SizedBox(height: 20,));
    lview.add(Text(
      name+str,//SummaryPageData.chartdata[i]['meta']['columns'][1]['name'],
      style: TextStyle(
          fontWeight: FontWeight.bold
      ),
    ));
    lview.add(SizedBox(height: 5,));
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
  void initState() {
    super.initState();
    SetPageData.updata = (){
      setState(() {

      });
    };
  }  //自定义方法 私有方法 当前类可以使用 返回的是Widget组件
  List<Widget>  _listViewData(){
    List<Widget> list = [];
    list.add(SizedBox(height: 5,));
    list.add(_buildCupertinoSegmentedControl());
    list.add(SizedBox(height: 5,));
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
               children: _getwidgget(arr,name,str,i)
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
