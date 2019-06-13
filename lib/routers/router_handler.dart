import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:giant_property/views/home/home.dart';
import 'package:giant_property/views/404.dart';
import 'package:giant_property/views/web_view_page/web_view_page.dart';

//首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return AppPage();
  },
);
var widgetNotFoundHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new WidgetNotFound();
});
var webViewPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  String url = params['url']?.first;
  return new WebViewPage(url, title);
});