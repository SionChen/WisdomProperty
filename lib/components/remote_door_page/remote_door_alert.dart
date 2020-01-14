import 'package:flutter/material.dart';

import 'package:giant_property/model/remote_door/remote_door_list_model.dart';
import 'package:giant_property/utils/shared_preferences/shared_preferences.dart';
import 'package:giant_property/views/home/home.dart';
import 'package:giant_property/main.dart';
import 'package:giant_property/components/loading_components.dart';
import 'package:giant_property/utils/network/net_utils.dart';
class RemoteDoorAlertWeight extends StatelessWidget {
  static RemoteDoorListModel remoteDoorListModel;
  static bool _open = true;//是否是开门.
    //显示弹窗.
  static void showRemoteDoorAlert(RemoteDoorListModel model,BuildContext context,bool open){
    remoteDoorListModel = model;
    _open = open;
    showDialog<void>(
      context: context,
      barrierDismissible: true,//点击弹层外部是否消失.
      builder: (BuildContext context){
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                height: 168,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _columns(model,context),
                ),
              ),
            ),
            
          ),
        );
      }
    );
  }

  static List<Widget> _columns (RemoteDoorListModel model,BuildContext context){
    List<Widget> colums  = [];
    colums.add(
      SizedBox(
        height: 28,
      ),
    );
    colums.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          _open?'请确认是否开门':'请确认是否关门',
          style: Theme.of(context).textTheme.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )
      
    );
    colums.add(
      SizedBox(
        height: 16,
      ),
    );
    colums.add(
      Text(
        model.name,
        style: Theme.of(context).textTheme.subhead,
      ),
    );
    colums.add(
      SizedBox(
        height: 24,
      ),
    );
    colums.add(
      Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(width: 0.5,color: Theme.of(context).textTheme.subtitle.color),
                ),
                child: Center(
                  child: Text('取消',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(22),
                  //border: Border.all(width: 0.5,color: Theme.of(context).accentColor),
                ),
                child: Center(
                  child: Text('确定',
                    style: TextStyle(color: Colors.white,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.transparent,
                    decorationStyle: TextDecorationStyle.dotted,
                    fontSize: 14.0),
                  ),
                ),
              ),
              onTap: (){
                _setCloseOrOpen(context);
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      )
      // FlatButton(
      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      //       color: Colors.white,
            // child: Text('取消',
            //   style: TextStyle(
            //     color:Theme.of(context).textTheme.subtitle.color,
            //     fontSize:  Theme.of(context).textTheme.subtitle.fontSize,
            //   ),
            // ),
      //       onPressed: (){
      //         Navigator.of(context).pop();
      //       },
      // ),
    );
    return colums;
  }

  static Future<Map> _setCloseOrOpen(BuildContext context) async{
    Map<String,dynamic> params = {};
    if(remoteDoorListModel == null){return Map();};
    String url = 'https://www.fastmock.site/mock/a5aedf2d79d5b9f6332deaccf5797002/giantProperty/channel/channel_open';
    params['operate'] = _open?'open':'close';
    params['channel_id'] = remoteDoorListModel.channelId;
    params['type'] = remoteDoorListModel.type;
    var response;
    try{
      LoadingWidegt.showLoading(context,loadingText: '操作中...');
      response = await NetUtils.post(url, params);
      print(response);
      LoadingWidegt.disMiss();
      Navigator.of(context).pop();
      if (response['status_code']=='100000') {
        AppPage.homeScaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: Text("操作成功")
        ));
      }else{
        
        AppPage.homeScaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: Text("操作失败")
        ));
      }
    }catch(e){
      print(e);
    }
    return response;
  }
  @override  
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
// class RemoteDoorAlertWeight extends StatefulWidget {
//   @override
//   RemoteDoorAlertWeight({Key key}):super (key:key);
//   RemoteDoorAlertWeightState createState() => RemoteDoorAlertWeightState();
// }

// class RemoteDoorAlertWeightState extends State<RemoteDoorAlertWeight> {

  // //显示弹窗.
  // void showRemoteDoorAlert(RemoteDoorListModel model){
  //   print(model);
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }