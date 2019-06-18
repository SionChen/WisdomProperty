import 'package:flutter/material.dart';

import 'package:giant_property/components/first_page/case_order_list_item.dart';
import 'package:giant_property/components/list_view_components.dart';
import 'package:giant_property/model/case_order/case_order_model.dart';

class CaseOrderListRefreshView extends StatefulWidget{
  final status;//状态
  final requestApi;//请求方法
  CaseOrderListRefreshView(this.status,this.requestApi);
  @override
  _CaseOrderListRefreshViewState createState(){
    return _CaseOrderListRefreshViewState();
  }
}
class _CaseOrderListRefreshViewState extends State<CaseOrderListRefreshView> with AutomaticKeepAliveClientMixin{
  bool isLoading = false; // 是否正在请求数据中.
  bool _hasMore = true; // 是否还有更多数据可加载.
  int _pageIndex = 1; // 页面的索引.
  int _pageTotal = 0; // 页面的索引.
  List items = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  void initState() {
    super.initState();
    _getMoreData();
    _scrollController.addListener(() {
      print('pixels:  ${_scrollController.position.pixels} maxScrollExtent: ${_scrollController.position.maxScrollExtent}');
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent&&_scrollController.position.pixels>0) {
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
      List newEntries = await httpRequest();
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
  // 下拉加载的事件，清空之前list内容，取前X个
// 其实就是列表重置
  Future<Null> _handleRefresh() async {
    _pageIndex = 1;
    List newEntries = await httpRequest();
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
  // 伪装吐出新数据.
  Future<List<CaseOrderModel>> httpRequest() async {
    if (widget.requestApi is Function) {
      final listObj = await widget.requestApi({'pageIndex': _pageIndex,'status':widget.status});
      _pageIndex = listObj['pageIndex'];
      _pageTotal = listObj['total'];
      print(listObj);
      return listObj['list'];
    }else{
      return [];
    }
  }
  @override
  Widget build(BuildContext context){
    super.build(context);
    return RefreshIndicator(
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),//这里是为了不满一页也可以下拉刷新.
        controller: _scrollController,
        itemCount: items.length+1,
        itemBuilder: (context,index){
          if (index == items.length) {
            return ListViewLoadMoreIndicator(hasMore: _hasMore,isLoading: isLoading,);//底部加载更多提示
          }else{
            return CaseOrderListItem(items[index]);
          }
          
        },
      ),
      onRefresh: _handleRefresh,
    );
  }

  
}