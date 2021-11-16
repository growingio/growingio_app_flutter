import 'dart:async';
import 'dart:convert';
import 'NetUtils.dart';
import 'SummaryPageData.dart';

class SetPageData {
   static String token = '';
   static String projectName = '';
   static String projectid = '';
   static List userInfo = [];
   static List<dynamic> project = [];
   static var pushSummaryPage = (){};
   static var updata = (){};
   static void getUserInfoRequest() async{
      Map<String, String> header = {
         "token":token,
         "AccessToken":token,
         "Accept":"application/json"
      };
      String body = await NetUtils.get('https://www.growingio.com/user',header);
      if(body == ''){
         print('获取UserInfo失败');
         return ;
      }
      Map<String, dynamic> response = jsonDecode(body);

      String str = "name:" + response['name'];
      userInfo.add(str);
      str = "email:" + response["email"];
      userInfo.add(str);
      str = "mobile:" + response["mobile"];
      userInfo.add(str);
      str = "company:" + response["profile"]['company'];
      userInfo.add(str);
      print('str $str company $userInfo');
   }
   static void getProject() async{
      Map<String, String> header = {
         "Authorization":token,
         "Content-Type":"text/plain"
      };
      dynamic body = await NetUtils.get('https://gta.growingio.com/users/account/projects',header);
      if(body == null){
         print('获取getProject失败');
         return ;
      }
      print('getProject body $body');
      List<dynamic> response = jsonDecode(body);
      project = response;
      projectName = project[0]['name'];
      projectid = project[0]['id'];
      print('getProject response $project');
      SummaryPageData.getData();
      //func();
   }
}

