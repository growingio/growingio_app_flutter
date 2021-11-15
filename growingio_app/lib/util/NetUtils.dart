import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetUtils {
  // get请求的封装，传入的两个参数分别是请求URL和请求参数，请求参数以map的形式传入，会在方法体中自动拼接到URL后面
  static Future<String> get(String url,   Map<String, String> params ) async {
    String result = "";
    final putResponse = await http.get(url,headers: params).then((response) {
      if(response.statusCode == 200){
        Utf8Decoder decode = new Utf8Decoder();
        result = decode.convert(response.bodyBytes);
      }else{
        print('数据请求错误：$url ${response.statusCode}');
      }
    });
    return Future.value(result);
  }
  // post请求
  static Future<String> posts(String url,  Map<String, String> header, Map<String, dynamic> params) async {
    String result = "";
    // final putData = jsonEncode(params);// 处理提交参数
    // print('putData :$putData')
    //http.post(url,headers: header,body: jsonEncode(params));
    final putResponse = await http.post(url,
        headers: header,
        body: jsonEncode(params)
    ).then((response){
      if(response.statusCode == 200){
        Utf8Decoder decode = new Utf8Decoder();
        result = decode.convert(response.bodyBytes);
      }else{
        print('数据请求错误：${response.statusCode}');
      }
    });
    return Future.value(result);
  }
  // post请求
  static Future<dynamic> post(String url, {required Map<String, String> params}) async {
    dynamic result;
    final putData = jsonEncode(params);// 处理提交参数
    print('putData :$putData');
    final putResponse = await http.post(url,
        headers: {"content-type": "text/plain"},
        body: putData
    ).then((response){
    if(response.statusCode == 200){
      Utf8Decoder decode = new Utf8Decoder();
      result = decode.convert(response.bodyBytes);
      //result = response.body;
    }else{
    print('数据请求错误：${response.statusCode}');
    }
    });
    return Future.value(result);
  }
}
