import 'dart:async';
import 'dart:convert';
import 'NetUtils.dart';
import 'SetpageData.dart';

class RealTimePageData {
  static List  realtime = [];
  static List realtimerequest = [];
  static List chartkey = [];
  static List<dynamic> chartdata = [];
  static var updata1 = (){};
  static void getrealtimeDashBoards() async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic str = await NetUtils.get("https://gta.growingio.com/v4/projects/"+SetPageData.projectid+'/dashboards?type=realtime',header);
    if(str == null){
      print('getData 失败');
    }
    print('getData $str');
    print('getrealtimeDashBoards');
    realtime = jsonDecode(str.toString());
    RefreshBodyRealTime();
  }
  static void getrealtimeEvents(String urlstr,int count ) async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic str = await NetUtils.get(urlstr,header);
    if(str == null){
      print('getData 失败');
    }
    print('getrealtimeDashBoards $str');
    realtimerequest.add(jsonDecode(str.toString()));
    if(realtimerequest.length == count){
      print('RefreshRealTimeApplicationBody');
      RefreshRealTimeApplicationBody();
    }
  }
  static void getChartDataRealTime(Map<String, dynamic>requestbody,int count, String key )async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic str = await NetUtils.posts("https://gta.growingio.com/v5/projects/"+SetPageData.projectid+"/chartdata", header, requestbody);
    if(str == null){
      print('getData 失败');
    }
    print('getData $str');
    print('count chartkey.length $count ${chartkey.length}');
   // realtimerequest.add(jsonDecode(str.toString()));
   //if(realtimerequest.length == count){
      chartdata.add(jsonDecode(str.toString()));
      chartkey.add(key);
      if(chartkey.length == count){
        print('RefreshOverView');
        RefreshOverView();
      //}
    }
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
  static void RefreshBodyRealTime() async{
    List components = realtime[0]["components"];
    for(int i = 0;i<components.length;i++){
      Map<String, dynamic> dic =components[i];
      String urlstr ;
      String  resourceType = '';
      if(dic["resourceType"] == "eventAnalysis"){
        resourceType = "events";
    }
    else if( dic["resourceType"] =="retentionAnalysis"){
    resourceType = "retentions";

    }
    else if(dic["resourceType"] == "dashboardComment"){
    resourceType = "dashboardComment";
    }
    urlstr = "https://gta.growingio.com/v4/projects/"+SetPageData.projectid+"/dashboards/"+dic["dashboardId"]+"/"+resourceType+"/"+dic["resourceId"];
        //socket 获取body
      getrealtimeEvents(urlstr, components.length);
  }
  }

  static void RefreshRealTimeApplicationBody() async{
    List arr =realtimerequest;
    for(int i = 0;i<arr.length;i++){
    Map<String, dynamic> dic = {};
    dic["name"] = arr[i]["name"];
    dic["chartType"] = arr[i]["chartType"];
    dic["type"] = "realtime";
    dic["metrics"] = arr[i]["measurements"];
    //dic[@"metrics"][@"platform"] = @[@"all"];
    if(arr[i]["filter"] != null){
    dic["filter"] = arr[i]["filter"];
    }
    if(arr[i]["orders"] != null){
    dic["orders"] = arr[i]["orders"];
    }
    if(arr[i]["id"] != null){
    dic["id"] = arr[i]["id"];
    }
    if(arr[i]["dataSource"] != null){
    dic["dataSource"] = arr[i]["dataSource"];
    }
    dic["dimensions"] = arr[i]["dimensions"];
    dic["attrs"] = arr[i]["attrs"];
    dic["granularities"] =arr[i]["granularities"];
    if(dic["name"] == "此时此刻有："){

    }else{
    dic["timeRange"] = arr[i]["timeRange"];
    }
    dic["targetUser"] = arr[i]["targetUser"]["id"];
    print("getChartDataRealTime");
    getChartDataRealTime(dic,arr.length,dic["name"]);
  }
  }

  //根据数据生成图表
  static void RefreshOverView(){
    updata1();
    print('getrealtimeDashBoards根据数据生成图表');
    print('getrealtimeDashBoards RealTime key$chartdata');
  }

}