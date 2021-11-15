import 'dart:async';
import 'dart:convert';
import 'NetUtils.dart';
import 'SetpageData.dart';

class SummaryPageData {
  static List chartdata = [];
  static List chartkey = [];
  static Map<String, dynamic> body = {};
  static String date = "day:2,1";
  static List plat = ["iOS", "Android"];
  static List name = [];
  static int id = 50;
  static void getData() async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic str = await NetUtils.get('https://gta.growingio.com/v3/projects/'+SetPageData.projectid+'/dashboards/overview',header);
    if(str == null){
      print('getData 失败');
    }
    print('getData $str');
    Map<String, dynamic> response = jsonDecode(str.toString());
    body = response["chartList"];
    date = response["chartList"]['oneDayWeb'][0]['data']['timeRange'];
    refreshBody();
  }
  static List getName(List<dynamic> arr){
    List num = [];
    for(int i=0;i<arr.length;i++){
      if(arr[i]['name'] != null){
        num.add(arr[i]['name']);
      }
    }
    return num;
  }
  static void refreshBody() async{
    List<dynamic> arr = body['oneDayWeb'];
    name = getName(arr);
    for(int i=0;i<arr.length;i++){
      Map<String, dynamic>  dic = {};
      dic['id'] = id++;
      dic['projectId'] = SetPageData.projectid;
      dic['name'] = SetPageData.projectName;
      dic['metrics'] = arr[i]["data"]["metrics"];
      dic['dimensions'] = arr[i]["data"]["dimensions"];
      dic['granularities'] = arr[i]["data"]["granularities"];
      dic['filter'] = {
          "op": "and",
          "exprs": [{
          "key": "b",
          "op": "in",
          "name": "平台",
          "values": plat
          }]
      };
      dic['timeRange'] = date;
      dic['targetUser'] = arr[i]["data"]["targetUser"];
      dic['chartType'] = arr[i]["data"]["chartType"];
      dic['attrs'] = {};
      getChartData(dic, arr.length, name[i]);
    }

  }
  static void getChartData(Map<String, dynamic> requestbody,int count, String key) async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic response = await NetUtils.posts('https://gta.growingio.com/v5/projects/'+SetPageData.projectid+'/chartdata', header, requestbody);
    if(response == null){
      print('getChartData 失败');
    }
    chartdata.add(jsonDecode(response));
    chartkey.add(key);
    if(chartkey.length == count){
      RefreshOverView();
    }
  }
  //根据数据生成图表
  static void RefreshOverView(){
    SetPageData.func();
    SetPageData.updata();
  }

}