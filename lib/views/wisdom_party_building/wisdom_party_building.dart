import 'package:flutter/material.dart';

import 'package:giant_property/utils/network/net_utils.dart';
import 'package:giant_property/model/wisdom_party_building/wisdom_party_building_list_model.dart';

import 'package:giant_property/components/wisdom_party_building/wisdom_party_building_list_view.dart';
import 'package:giant_property/components/list_view_components.dart';
class WisdomPartyBuildingPage extends StatefulWidget{

  @override
  _WisdomPartyBuildingPageState createState(){
    return _WisdomPartyBuildingPageState();
  }
}
class _WisdomPartyBuildingPageState extends State<WisdomPartyBuildingPage>{
  bool isLoading = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageIndex = 0; // 页面的索引
  int _pageTotal = 0; // 页面的索引
  ScrollController _scrollController = new ScrollController();
  List<WisdomPartyBuildingListModel> items = [];
  @override
  void initState() {
    super.initState();
    _getMoreData();
    
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }
  // list探底，执行的具体事件
  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      //if(_hasMore){ // 还有数据可以拉新
      List<WisdomPartyBuildingListModel> newEntries = await httpRequest();
      //if (newEntries.isEmpty) {
      _hasMore = (_pageIndex <= _pageTotal);
      if (this.mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
        });
      }
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
    }
  }
  @override
  Widget build(BuildContext context){
    return RefreshIndicator(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: items.length+1,
        itemBuilder: (context,index){
          if (index == items.length) {
            return ListViewLoadMoreIndicator(hasMore: _hasMore,isLoading: isLoading,);//底部加载更多提示
          }else{
            return WisdomPartyBuildingListView(items[index]);
          }
          
        },
      ),
      onRefresh: _handleRefresh,
    );
  }
  //  刷新动作
  Future<Null> _handleRefresh() async{
    _pageIndex = 1;
    List<WisdomPartyBuildingListModel>  newEntries = await httpRequest();
    if (this.mounted) {
      setState(() {
        items.clear();
        items.addAll(newEntries);
        isLoading = false;
        _hasMore = true;
        return null;
      });
    }
  }
  // 伪装吐出新数据
  Future<List<WisdomPartyBuildingListModel>> httpRequest() async {
      final listObj = await getIndexListData({'pageIndex': _pageIndex});
      _pageIndex = listObj['pageIndex'];
      _pageTotal = listObj['total'];
      print(listObj);
      return listObj['list'];
  }
  //获取数据
  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
    //const juejin_flutter = 'http://jmtapp.superwan.cn/msi/home.php';
    const wisdom_url = 'http://mptestapi.cngiantech.com:80/api/content/notices';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    final _param  = {'page':pageIndex,'pre_page':20,};
    var responseList = [];
    var  pageTotal = 0;

    try{
      var response = await NetUtils.get(wisdom_url, params: _param);
      responseList = response['data']['data'];
      pageTotal = response['data']['total'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    }catch(e){

    }
    pageIndex += 1;
    List<WisdomPartyBuildingListModel> resultList = new List();
    for (int i = 0; i < responseList.length; i++) {
      try {
        WisdomPartyBuildingListModel cellData = new WisdomPartyBuildingListModel.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {"list":resultList, 'total':pageTotal, 'pageIndex':pageIndex};
    return result;
  }
}