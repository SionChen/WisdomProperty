import 'package:flutter/material.dart';

//上拉加载更多控件.
class ListViewLoadMoreIndicator extends StatelessWidget{
  final bool hasMore;
  final bool isLoading;
  final String noMoreText;
  ListViewLoadMoreIndicator({
    @required
    this.hasMore,
    @required
    this.isLoading,
    this.noMoreText = '数据没有更多了！！！',
  });
  // 加载中的提示.
  Widget _loadText() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Text(noMoreText),
      ),
    ));
  }
  @override
  Widget build(BuildContext context){
    if (hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: Column(
          children: <Widget>[
            new Opacity(
              //opacity: isLoading ? 1.0 : 0.0,
              opacity: 1,
              child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)),
            ),
            SizedBox(height: 20.0),
            Text(
              '稍等片刻更精彩...',
              style: TextStyle(fontSize: 14.0),
            )
          ],
        )
            //child:
            ),
      );
    } else {
      return _loadText();
    }
  }
}
class ListViewEmptyComponents extends StatelessWidget{
  final String imagePath;
  final String title;
  ListViewEmptyComponents({
    this.imagePath = 'assets/images/equipmentBlank.png',
    this.title = '空白页面',
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.bottom,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ),
    );
  }
}