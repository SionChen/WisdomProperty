import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as prefix0;

import 'package:giant_property/components/list_view_components.dart';
class RemoteDoorPage extends StatefulWidget{

  @override
  _RemoteDoorPageState createState(){
    return _RemoteDoorPageState();
  }
}
class _RemoteDoorPageState extends State<RemoteDoorPage>{
  List items = [];
  Widget _buidlWidegt(BuildContext context){
    if (items.isEmpty) {
      return ListViewEmptyComponents();
    } else {
      return ListView.builder(
        itemCount: items.isEmpty?1:items.length,
        itemBuilder: (context,index){

          return Container(
            width: 200,
            height: 200,
            color: Colors.yellow
          );
          
        },
      );
    }
  }
  Widget build(BuildContext context){
    return RefreshIndicator(
      //child:_buidlWidegt(context),
      child: ListView.builder(
        itemCount: items.isEmpty?1:items.length,
        itemBuilder: (context,index){
          // return Container(
          //   width: 200,
          //   height: 200,
          //   color: Colors.yellow
          // );
          if (items.isEmpty) {
            return ListViewEmptyComponents();
          }else{
            return Container(
              width: 200,
              height: 200,
              color: Colors.yellow
            );
          }
        },
      ),
      onRefresh: _handleRefresh,
    );
  }
  //模拟刷新
  Future<Null> _handleRefresh() async{
    await Future.delayed(Duration(seconds: 2),(){
      return null;
    });
    if (this.mounted) {
        setState(() {
        return null;
      });
    }
  }
}