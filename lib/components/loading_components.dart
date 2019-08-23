import 'package:flutter/material.dart';


class LoadingWidegt extends StatelessWidget {
  static BuildContext showContext = null;
  static void  showLoading(BuildContext context,{String loadingText}){
    showContext = context;
    //设置模拟消失.
    // _setDelayedDismiss().then((_){
    //   _disMiss();
    // });
    showDialog<void>(
      context: context,
      barrierDismissible: true,//点击弹层外部是否消失.
      builder: (BuildContext context){
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 100,
                minHeight: 100,
                maxHeight: 100,
                maxWidth: 100,
              ),
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                //height: 168,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _columns(context,loadingText: loadingText),
                ),
              ),
            ),
            
          ),
        );
      }
    );
  }
  //模拟延迟消失.
  static Future<void> _setDelayedDismiss() async{
    await Future.delayed(Duration(seconds: 2));
  }
  //消失方法.
  static void disMiss(){
    if (showContext == null) {
      return;
    }else{
      Navigator.of(showContext).pop();
    }
  }
  static List<Widget>  _columns(BuildContext context,{String loadingText}){
    List<Widget> columns = [];
    columns.add(
      new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)),
    );
    columns.add(
      SizedBox(
        height: 15,
      ),
    );
    columns.add(
      Text(loadingText,
        style: Theme.of(context).textTheme.title,
      ),
    );
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}