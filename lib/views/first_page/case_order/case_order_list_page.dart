import 'package:flutter/material.dart';

import 'package:giant_property/utils/network/net_utils.dart';
import 'package:giant_property/model/case_order/case_order_model.dart';
import 'package:giant_property/views/first_page/case_order/case_order_list_refresh_view.dart';

class  CaseOrderListPage extends StatefulWidget{
  final bool isWarranty;//是否是报修 工单 否则是投诉工单.
  CaseOrderListPage({
    this.isWarranty = false,
  });
  @override
  _CaseOrderListPageState createState(){
    return _CaseOrderListPageState();
  }
}

class _CaseOrderListPageState extends State<CaseOrderListPage> with SingleTickerProviderStateMixin{
  TabController controller;
  List<String> tabTitles = [];
  List<Widget> tabBars = [];

  @override
  void initState() {
    super.initState();
    tabTitles = [
      '待处理',
      '全部',
    ];
    controller = TabController(length: tabTitles.length,vsync: this);
    for (int i = 0; i < tabTitles.length; i++) {
      tabBars.add(new Tab(text: tabTitles[i],));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  //获取数据.
  Future<Map> getListData(Map<String,dynamic> params) async{
    var url = widget.isWarranty?'http://mptestapi.cngiantech.com:80/api/case/maintains':'http://mptestapi.cngiantech.com:80/api/case/complains';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    var status = params['status'];
    var related = status =='处理中' ?'流转给我':'';
    final _param  = {'page':pageIndex,'pre_page':20,'status':status,'related':related};
    var responseList = [];
    var  pageTotal = 0;
    try{
      var response = await NetUtils.get(url, params: _param);
      responseList = response['data']['data'];
      pageTotal = response['data']['total'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    }catch(e){
      print(e);
    }
    pageIndex += 1;
    List<CaseOrderModel> resultList = new List();
    for (int i = 0; i < responseList.length; i++) {
      try {
        CaseOrderModel cellData = new CaseOrderModel.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {"list":resultList, 'total':pageTotal, 'pageIndex':pageIndex};
    return result;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isWarranty?'我的报修':'我的投诉'),
        elevation: 0.0,
        bottom: TabBar(
          controller: controller,
          tabs: tabBars,
          //tab标签的下划线颜色
          indicatorColor: Theme.of(context).accentColor,
          
          // labelColor: const Color(0xFF000000),
          indicatorWeight: 3.0,
          indicatorSize: TabBarIndicatorSize.label,
          //labelcolor 选中的
          labelColor: Theme.of(context).accentColor,
          //labelColor: Colors.green,
          unselectedLabelColor: const Color(0xFF8E8E8E),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          CaseOrderListRefreshView('处理中', getListData),
          CaseOrderListRefreshView('', getListData),
        ],
      ),
    );
  }
}