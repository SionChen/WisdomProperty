import 'package:flutter/material.dart';


class MyNavigationBar extends StatefulWidget{
  final String title;

  MyNavigationBar(this.title);

  @override
  _MyNavigationBarState createState(){
    return _MyNavigationBarState();
  }
}
class _MyNavigationBarState extends State<MyNavigationBar> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context){
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Row(
          children: <Widget>[
            Text(widget.title,
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).textTheme.title.color,
                ),
            ),
          ],
        ),
      ),
    );
  }
}