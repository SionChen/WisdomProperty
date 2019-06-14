import 'package:flutter/material.dart';

import 'package:giant_property/model/case_order/case_order_page_model.dart';
import 'package:giant_property/model/wisdom_party_building/wisdom_party_building_list_model.dart';
import 'package:giant_property/model/case_order/case_order_model.dart';

class ListHeaderItem extends StatelessWidget{
  final WisdomPartyBuildingListModel wisdomModel;
  ListHeaderItem(this.wisdomModel);

  String _dateString(){
    var nowTime = DateTime.now();
    return '今天是 ${nowTime.year} 年 ${nowTime.month} 月 ${nowTime.day} 日';
  }
  Widget _dateWiget(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
         Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            //border: Border.all(color: Color(0xFF999999),width: 0.5),
            color: Color(0xFFF4BB47),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
              child: Text(_dateString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
         ),
      ],
    );
  }
  Widget _itemCard(BuildContext context){
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xFF999999),width: 0.5),
              ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 16),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                   wisdomModel.title,
                   style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    wisdomModel.body,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
    
          ),
        ),
      ],
    );
  }
  Widget _buildWiget(BuildContext context){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _dateWiget(),
            SizedBox(
              height: 20,
            ),
            _itemCard(context),
          ],
        ),
      ),
    );
  }
  @override 
  Widget build(BuildContext context){
    return _buildWiget(context);
  }
}
class ListViewItem extends StatelessWidget{
  final CaseOrderPageModel pageModel;
  ListViewItem(this.pageModel);

  Widget _buildRow(BuildContext context){
      return Row(
        children: <Widget>[
          Container(
            width: 90,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Image.asset('assets/images/homeBlueCorner.png',
                    ),
                ),
                Center(
                  child: Text(
                    '${pageModel.data.length}',
                    style: TextStyle(color: Colors.white,
                      fontSize: 52,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          _titlesWidget(context),
        ],
      );
  }
  List<Widget> _titleColumnList(BuildContext context){
    List<Widget> columns = [];
    columns.add(
      Row(
            children: <Widget>[
              Text('没有做后续点击',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.arrow_right,
              ),
            ],
      ),
    );
    if (pageModel.data.length>0) {
      CaseOrderModel model = pageModel.data[0];
      columns.add(
        _subtielWidget(context, model),
      );
    }
    if (pageModel.data.length>1) {
      CaseOrderModel model = pageModel.data[1];
      columns.add(
        _subtielWidget(context, model),
      );
    }
    return columns;
  }
  Widget _subtielWidget(BuildContext context,CaseOrderModel model){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFC80D29),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
            child: Text(
              'NEW',
              style: TextStyle(color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(model.title,
          style: Theme.of(context).textTheme.title,
        ),
      ],
    );
  }
  Widget _titlesWidget(BuildContext context){
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _titleColumnList(context),
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    //homeBlueCorner
    
    return Container(
      color: Colors.white,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
        elevation: 6,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),  //设置圆角,
        child: Container(
          height: 107,
          child: Stack(
            children: <Widget>[
                Positioned(
                  right: 0,
                  child: Image.asset(pageModel.typeIconImageString,
                  alignment: Alignment.centerRight,
                  ),
                ),
                _buildRow(context),
            ],
          ),
        ),
      ),
    );
  }
}