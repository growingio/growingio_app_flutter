import 'dart:async';
import 'dart:convert';
import 'NetUtils.dart';
import 'SetpageData.dart';

class SeeBoardPageData {
  static List realtimerequest = [];
  static List chartViewArr = [];
  static Map<String, dynamic> gayaxp = {};
  static Map<String, dynamic> chartdata = {};
  static List NoDataView = [];
  static List brokenLine = [];
  static List columnar = [];
  static int id = 50;

  static void getSeeDashBoards(String str) async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic responseObject = await NetUtils.get('https://gta.growingio.com/v4/projects/'+SetPageData.projectid+'/dashboards/'+str,header);
    if(str == null){
      print('getData 失败');
    }
    gayaxp = responseObject;
    RefreshBodySeeBoard();
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
  static void RefreshBodySeeBoard() async{
    List components = gayaxp["components"];
    for(int i = 0;i<components.length;i++){
      Map<String, dynamic> dic =components[i];
      String urlstr;
      String resourceType = '';
    if(dic["resourceType"] == "eventAnalysis"){
    resourceType = "events";
    }
    else if(dic["resourceType"] == "retentionAnalysis"){
    resourceType = "retentions";

    }
    else if(dic["resourceType"] == "dashboardComment"){
    resourceType = "dashboardComment";
    }
      urlstr = "https://gta.growingio.com/v4/projects/"+SetPageData.projectid+'/dashboards/'+dic["dashboardId"]+'/'+resourceType+'/'+dic["resourceId"];
    //socket 获取body
     getSeeEvents(urlstr,components.length);
    }

  }
  static void getSeeEvents(String urlstr,int count) async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic response = await NetUtils.get('https://gta.growingio.com/v5/projects/'+SetPageData.projectid+'/chartdata', header);
    if(response == null){
      print('getChartData 失败');
    }
    realtimerequest.add(jsonDecode(response));
    if(realtimerequest.length == count){
      RefreshSeeBoardApplicationBody();
    }
  }

  static void RefreshSeeBoardApplicationBody(){
    List arr = realtimerequest;
    for(int i = 0;i<arr.length;i++){
      Map<String, dynamic> dic = {};
    dic["id"] = arr[i]["id"];
    dic["projectId"] = SetPageData.projectid;
    dic["name"] = arr[i]["name"];
    //dic[@"aggregation"] =  true;
    dic["attrs"] = arr[i]["attrs"];
    dic["orders"] = arr[i]["orders"];
    dic["limit"] = arr[i]["limit"];
    dic["dimensions"] = arr[i]["dimensions"];
    dic["filter"] = arr[i]["filter"];
    dic["granularities"] = arr[i]["granularities"];
    dic["metrics"] = arr[i]["measurements"];
    dic["dimensions"] = arr[i]["dimensions"];
    dic["targetUser"] = arr[i]["targetUser"]["id"];
    dic["timeRange"] = arr[i]["timeRange"];
    dic["dataSource"] = arr[i]["dataSource"];
    dic["chartType"] = arr[i]["chartType"];
    getChartDataSeeBoard(dic,arr.length,dic["name"]);
    }
  }

  static void getChartDataSeeBoard(Map<String, dynamic> requestbody,int count,String key) async{
    Map<String, String> header = {
      "Authorization":SetPageData.token,
      "Content-Type":"text/plain"
    };
    dynamic response = await NetUtils.posts('https://gta.growingio.com/v5/projects/'+SetPageData.projectid+'/chartdata', header, requestbody);
    if(response == null){
      print('getChartData 失败');
    }
    chartdata[key] = response;
    if(chartdata.length == count-4){
      RefreshOverView();
    }
  }
  static void RefreshOverView(){
    List arr = realtimerequest;
    for(int i = 0;i<arr.length;i++){
      Map<String, dynamic> dic = {};
      dic["id"] = arr[i]["id"];
      dic["projectId"] = SetPageData.projectid;
      dic["name"] = arr[i]["name"];
      //dic[@"aggregation"] =  true;
      dic["attrs"] = arr[i]["attrs"];
      dic["orders"] = arr[i]["orders"];
      dic["limit"] = arr[i]["limit"];
      dic["dimensions"] = arr[i]["dimensions"];
      dic["filter"] = arr[i]["filter"];
      dic["granularities"] = arr[i]["granularities"];
      dic["metrics"] = arr[i]["measurements"];
      dic["dimensions"] = arr[i]["dimensions"];
      dic["targetUser"] = arr[i]["targetUser"]["id"];
      dic["timeRange"] = arr[i]["timeRange"];
      dic["dataSource"] = arr[i]["dataSource"];
      dic["chartType"] = arr[i]["chartType"];
      getChartDataSeeBoard(dic,arr.length,dic["name"]);
    }
  }

}