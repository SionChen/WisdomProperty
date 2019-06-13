import 'dart:async';

import 'package:dio/dio.dart';

import 'package:giant_property/utils/shared_preferences/shared_preferences_keys.dart';
import 'package:giant_property/utils/shared_preferences/shared_preferences.dart';

var dio = _getDio();
//Authorization = "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tcHRlc3RhcGkuY25naWFudGVjaC5jb21cL2FwaVwvYXV0aCIsImlhdCI6MTU2MDMzMTY4NSwiZXhwIjoxNTYwMzMyMjg1LCJuYmYiOjE1NjAzMzE2ODUsImp0aSI6InZTcEx4Z21FU0JjVEFmQmwiLCJzdWIiOjE3LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.HFzqg0CrDLu2zXtLG__btuuKpTgWCbhnXdmFad_Lqjc";
Dio _getDio(){
  var instance = new Dio();
  instance.options.headers = HttpHeaders;
  return instance;
}
Map<String,dynamic> HttpHeaders = {
  'Accept': 'application/prs.giantechMp.v2+json',
  'Authorization': 'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tcHRlc3RhcGkuY25naWFudGVjaC5jb21cL2FwaVwvYXV0aCIsImlhdCI6MTU2MDMzMTY4NSwiZXhwIjoxNTYwMzMyMjg1LCJuYmYiOjE1NjAzMzE2ODUsImp0aSI6InZTcEx4Z21FU0JjVEFmQmwiLCJzdWIiOjE3LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.HFzqg0CrDLu2zXtLG__btuuKpTgWCbhnXdmFad_Lqjc',
};
class NetUtils {
  static Future get(String url,{Map<String,dynamic> params}) async{
    var response = await dio.get(url, data: params);
    return  response.data;
  }

  static Future post(String url,Map<String,dynamic> params) async{
    var response = await dio.post(url, data: params);
    return response.data;
  }

  static Future login(String login_name,String password) async{
    const login_url = 'http://mptestapi.cngiantech.com:80/api/auth';
    final _param  = {'login_name':login_name,'password':password,};
    try {
      
      var response = await NetUtils.post(login_url, _param);
      
      //把个人信息放入httpheader
      dio.options.headers['Authorization'] = '${response['token_type']} ${response['access_token']}';
      print('header ${dio.options.headers}');
      //保存
      await SpUtil.getInstance()..putString(SharedPreferencesKeys.token, response['access_token']);
      return response;
    } catch (e) {
    }
  }
}