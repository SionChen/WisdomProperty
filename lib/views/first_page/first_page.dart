import 'package:flutter/material.dart';

import 'package:giant_property/utils/network/net_utils.dart';

import 'package:giant_property/model/wisdom_party_building/wisdom_party_building_list_model.dart';
import 'package:giant_property/model/case_order/case_order_page_model.dart';

import 'package:giant_property/components/first_page/first_page_list_item.dart';
class FirstPage extends StatefulWidget{

  @override
  _FirstPageState createState(){
    return _FirstPageState();
  }
}
class _FirstPageState extends State<FirstPage>{
  List items = [];
  bool isLoading = false; // 是否正在请求数据中
  WisdomPartyBuildingListModel wisdom;//文章信息
  CaseOrderPageModel complain;//投诉信息
  CaseOrderPageModel maintain;//维修信息
  @override
  void initState(){
    super.initState();
    _handleRefresh();
  }
  @override
  Widget build(BuildContext context){
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context,index){
          if (items[index]==wisdom) {
            return ListHeaderItem(items[index]);
          }else if(items[index].runtimeType == CaseOrderPageModel){
            return ListViewItem(items[index]);
          }
        },
      ),
      onRefresh: _handleRefresh,
    );
  }
  //  刷新动作
  Future<Null> _handleRefresh() async{
    List newEntries = await httpRequest();
    if (this.mounted) {
      setState(() {
        items.clear();
        items.addAll(newEntries);
        return null;
      });
    }
  }
  // 伪装吐出新数据
  Future<List> httpRequest() async {
      final listObj = await getIndexListData();
      print('listObj :$listObj');
      return listObj['list'];
  }
  //获取数据
  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
    const url = 'https://www.fastmock.site/mock/a5aedf2d79d5b9f6332deaccf5797002/giantProperty/home';
    var data = {};

    try{
      var response = await NetUtils.get(url,);
      print('response: $response');
      data = response['data'];
    }catch(e){

    }
    List resultList = new List();
    Map noticeMap = data['notice']??Map();
    Map maintainMap = data['maintain']??Map();
    Map complainMap = data['complain']??Map();
    if (noticeMap.isNotEmpty) {
      wisdom = WisdomPartyBuildingListModel.fromJson(noticeMap);
      resultList.add(wisdom);
    }
    if (maintainMap.isNotEmpty) {
      maintain = CaseOrderPageModel.fromJson(maintainMap);
      maintain.setType('M');
      resultList.add(maintain);
    }
    if (complainMap.isNotEmpty) {
      complain = CaseOrderPageModel.fromJson(complainMap);
      complain.setType('C');
      resultList.add(complain);
    }
    Map<String, dynamic> result = {"list":resultList,};
    return result;
  }
}