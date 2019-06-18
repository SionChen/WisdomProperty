import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:giant_property/model/case_order/case_order_model.dart';

class CaseOrderListItem extends StatelessWidget{
  final CaseOrderModel model;
  CaseOrderListItem(this.model);

  Widget _buildButton(BuildContext context){//状态按钮.
    return Container(
      height: 30,
      width: 70,
      decoration: BoxDecoration(
        color: model.status=='新工单'?Color(0xFFC80D29):model.status=='处理中'?Color(0xFFF4BB47):Color(0xFF999999),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),topLeft: Radius.circular(16)),
      ),
      child: Center(
        child: Text(model.status,
          style: TextStyle(color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

    );
  }
  Widget _buildTitle(BuildContext context){//标题和时间.
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 80, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(model.title,
            softWrap: true,//多行显示.
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 8,
          ),
          Text(model.updatedAt,
            style: Theme.of(context).textTheme.body2,
          ),
        ],
      ),
    );
  }
  Widget _buildColum(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _colums(context),
    );
  }
  List<Widget> _colums(BuildContext context){
    List<Widget> list = [];
    list.add(_buildTitle(context));
    list.add(
      SizedBox(
          height: 12,
      )
    );
    list.add(
      Padding(//分割线.
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Divider(
            height: 0.5,
            color: Theme.of(context).dividerColor,
          ),
        ),
    );
    list.add(//优先级.
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
              child: Text('优先级',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            Text(model.prior,
              style: TextStyle(
                color: model.prior=='高'?Color(0xFFC80D29):model.prior=='中'?Color(0xFFF4BB47):Color(0xFF2A59DD),
              ),
            )
          ],
        ),
      ),
    );
    list.add(//创建人.
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
              child: Text('创建人',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            Text(model.creater,
            )
          ],
        ),
      ),
    );
    if (model.dealer.isNotEmpty) {
      list.add(//当前处理人.
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
          child: Row(
            children: <Widget>[
              Container(
                width: 90,
                child: Text('当前处理人',
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              Text(model.dealer,
              )
            ],
          ),
        ),
      );
    }
    list.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Center(
            child:Container(
              height: 48,
              child: Center(
                child: Text('处理',
                  style: TextStyle(color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          onPressed: (){
            print('RaisedButton Clicked');
          },
        ),
      ),
    );
    return list;
  }
  @override
  Widget build(BuildContext context){

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
      elevation: 0,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            child: _buildColum(context),
          ),
          Positioned(//按钮.
            right: 0,
            top: 12,
            child: _buildButton(context),
          ),
        ],
      ),
    );
  }
}