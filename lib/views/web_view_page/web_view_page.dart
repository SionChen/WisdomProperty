import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:giant_property/routers/application.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);
  _WebViewPageState createState() => _WebViewPageState();
}
class _WebViewPageState extends State<WebViewPage> {
  
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 final flutterWebviewPlugin = new FlutterWebviewPlugin(); 
 var webTitle = "";
 var webViewLoadState;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webTitle = widget.title;
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state){
      webViewLoadState = state.type;
      if (state.type==WebViewState.finishLoad) {//加载完成.
        flutterWebviewPlugin.evalJavascript('document.title').then((string){
          setState(() {
            webTitle = string;
          });
        });
      }
    });
  }
  @override
  void dispose(){
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  Widget _indectorWidget(BuildContext context){
    if (webViewLoadState==WebViewState.finishLoad) {//加载完成隐藏.
      return Container();
    }else{//加载中显示加载动画.
      return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor));
    }
  }
  Future<bool> _requestPop() async{//拦截返回按钮
    Application.router.pop(_scaffoldKey.currentContext);
    //flutterWebviewPlugin.goBack();
    return false;
    //return new Future.value(false);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(webTitle),
          elevation: 0,
        ),
        body: WebviewScaffold(
          url: widget.url,
          withZoom: false,
          withLocalStorage: true,
          withJavascript: true,
          initialChild: Center(
            child: _indectorWidget(context),
          ),
          hidden: !(webViewLoadState==WebViewState.finishLoad),
        ),
      ),
      onWillPop: _requestPop,
    );
    // return Scaffold(
    //    key: _scaffoldKey,
    //   appBar: AppBar(
    //     title: Text(webTitle),
    //     elevation: 0,
    //   ),
    //   body: WebviewScaffold(
    //     url: widget.url,
    //     withZoom: false,
    //     withLocalStorage: true,
    //     withJavascript: true,
    //     initialChild: Center(
    //       child: _indectorWidget(context),
    //     ),
    //     hidden: !(webViewLoadState==WebViewState.finishLoad),
    //   ),
    // );
  }
}