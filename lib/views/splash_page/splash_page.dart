import 'package:flutter/material.dart';


class SplashPage extends StatelessWidget {
  final  initFuction;
  SplashPage(this.initFuction){
    
    
  }
  Widget _buildWidget(){
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/images/1242x2688.png'),
          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    if (initFuction is Function) {
      initFuction(context);
    }
    return Scaffold(
      body: _buildWidget(),
    );
  }
}