import 'package:flutter/material.dart';

import 'package:giant_property/model/remote_door/remote_door_list_model.dart';

class RemoteDoorListItem extends StatefulWidget{
  final RemoteDoorListModel model;
  RemoteDoorListItem(this.model);
  @override
  _RemoteDoorListItemState createState(){
    return _RemoteDoorListItemState();
  }
}
class _RemoteDoorListItemState extends State<RemoteDoorListItem>{


  List<Widget> _rows(BuildContext context){
    List<Widget> rows = [];
    rows.add(
      SizedBox(
          width: 12,
      )
    );
    rows.add(
      Expanded(
          child: Text(widget.model.name,
            style: Theme.of(context).textTheme.title,
          ),
      )
    );
    rows.add(
      SizedBox(
        width: 64,
        height: 40,
        child: FlatButton(
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Text('开门',
            style: TextStyle(
              color:Colors.white,
              fontSize:  Theme.of(context).textTheme.title.fontSize,
            ),
          ),
          onPressed: (){},
        ),
      ),
    );
    rows.add(
      SizedBox(
          width: 12,
      )
    );
    rows.add(
      SizedBox(
        width: 64,
        height: 40,
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Color(0xFFC80D29),
          child: Text('关门',
            style: TextStyle(
              color:Colors.white,
              fontSize:  Theme.of(context).textTheme.title.fontSize,
            ),
          ),
          onPressed: (){},
        ),
      ),
    );
    rows.add(
      SizedBox(
          width: 12,
      )
    );
    return rows;
  }
  Widget _buildRow(BuildContext context){
    return Row(
      children: _rows(context),
    );
  }
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
      child: Card(
        elevation: 6,
        color: Colors.white,
        child: Container(
          height: 64,
          child: _buildRow(context),
        ),
      ),
    );
  }
}