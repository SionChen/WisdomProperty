import 'dart:async';

import 'package:flutter/material.dart';

import 'package:giant_property/components/list_view_components.dart';
import 'package:giant_property/components/remote_door_page/remote_door_list_item.dart';
import 'package:giant_property/model/remote_door/remote_door_list_model.dart';
import 'package:giant_property/utils/network/net_utils.dart';
class RemoteDoorPage extends StatefulWidget{

  @override
  _RemoteDoorPageState createState(){
    return _RemoteDoorPageState();
  }
}
class _RemoteDoorPageState extends State<RemoteDoorPage>{
  List<RemoteDoorListModel> items = [];
  bool isLoading = false; // 是否正在请求数据中.
  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context){
    return RefreshIndicator(
      //child:_buidlWidegt(context),
      child: ListView.builder(
        itemCount: items.isEmpty?1:items.length,
        itemBuilder: (context,index){
          if (items.isEmpty) {
            return ListViewEmptyComponents();
          }else{
            return RemoteDoorListItem(items[index]);
          }
        },
      ),
      onRefresh: _handleRefresh,
    );
  }
  Future<List<RemoteDoorListModel>> _getData() async{
    List<RemoteDoorListModel> dataList = items;
    if (!isLoading) {
      // 如果上一次异步请求数据完成 同时有数据可以加载.
      if (mounted) {
        setState(() => isLoading = true);
      }
      const url = 'http://mptestapi.cngiantech.com:80/api/index/xzhy/channels';

      List<RemoteDoorListModel> sluiceList = [];//道闸数据.
      List<RemoteDoorListModel> guardsList = [];//门禁数据
      Map  responseMap = {};
      try{
        var response = await NetUtils.get(url, );
        responseMap= response['data'];
        print('responseMap: $responseMap');
      }catch(e){

      }
      List sluice =  responseMap['sluice'];
      List guards =  responseMap['guards'];
      for (int i = 0; i < sluice.length; i++) {
        try {
          RemoteDoorListModel cellData = new RemoteDoorListModel.fromJson(sluice[i]);
          sluiceList.add(cellData);
        } catch (e) {
          // No specified type, handles all
          print(e);
        }
      }
      for (int i = 0; i < guards.length; i++) {
        try {
          RemoteDoorListModel cellData = new RemoteDoorListModel.fromJson(guards[i]);
          guardsList.add(cellData);
        } catch (e) {
          // No specified type, handles all
        }
      }
      dataList = [];
      dataList.addAll(sluiceList);
      dataList.addAll(guardsList);
    }
    return dataList;
  }
  //刷新
  Future<Null> _handleRefresh() async{
    List<RemoteDoorListModel> dataList = await _getData();
    if (this.mounted) {
      setState(() {
        items = dataList;
        isLoading = false;
        return null;
      });
    }
  }
}