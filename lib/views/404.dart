import 'package:flutter/material.dart';

class WidgetNotFound extends StatelessWidget {

    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("404 not found"),
          ),
          body: Container(
              child:  Text("404 not found")
          )
      );
    }
}