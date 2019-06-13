import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:giant_property/routers/router_handler.dart';
class Routers{

  static String root = "/";
  static String home = "/home";
  static String webViewPage = '/web-view-page';
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        });
    router.define(root, handler: homeHandler);
    router.define(home, handler: homeHandler);
    router.define(webViewPage,handler:webViewPageHandler);
  }
  
}