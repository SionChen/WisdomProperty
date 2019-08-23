import 'package:flutter/material.dart';

import 'package:giant_property/routers/application.dart';
import 'package:giant_property/components/home/app_navigation_bar.dart';
import 'package:giant_property/utils/network/net_utils.dart';

import 'package:giant_property/views/first_page/first_page.dart';
import 'package:giant_property/views/remote_door_page/remote_door_page.dart';
import 'package:giant_property/views/wisdom_party_building/wisdom_party_building.dart';


class AppPage extends StatefulWidget{
  static GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _AppPageState createState(){
    return _AppPageState();
  }
}
class _AppPageState extends State<AppPage> with SingleTickerProviderStateMixin{
   
  static List tabData = [];
  List<BottomNavigationBarItem> myTabs = []; 
  String appBarTitle = '';
  
  @override
  void initState() {
    super.initState();

    _setMyTabsData();//设置底部icon
    appBarTitle = tabData[currentIndex]['text'];
    currenPage = tabBodies[currentIndex];
    
  }
  void _setMyTabsData(){
    int index = currentIndex;
    tabData = [
      {'text': '首页', 'icon':  Image.asset(index==0?'assets/images/tabBar_home_highlight.png':'assets/images/tabBar_home.png',width: 28,height: 28,)},
      {'text': '远程开门', 'icon':  Image.asset(index==1?'assets/images/tabBar_remote_door_highlight.png':'assets/images/tabBar_remote_door.png',width: 28,height: 28,)},
      {'text': '智慧党建', 'icon':  Image.asset(index==2?'assets/images/tabbar_wisdomPartyBuilding_highlight.png':'assets/images/tabbar_wisdomPartyBuilding.png',width: 28,height: 28,)}
    ];
    myTabs = [];
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new BottomNavigationBarItem(title: Text(tabData[i]['text'],) , icon: tabData[i]['icon']));
    }
  }
  @override
  void dispose() {

    super.dispose();
  }
  final List<Widget> tabBodies = [
    FirstPage(),
    RemoteDoorPage(),
    WisdomPartyBuildingPage(),
  ];
  int currentIndex = 0;
  var currenPage;
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      key: AppPage.homeScaffoldKey,
      appBar: AppBar(title: MyNavigationBar(appBarTitle),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,//阴影辐射范围
        ),
      body: IndexedStack(
        children: tabBodies,
        index: currentIndex,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(//阴影
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFededed),
                  blurRadius: 6.0,
                  //spreadRadius: 2.0,
                  offset: Offset(0, -3.0),
                ),
              ],
        ),
        child: BottomNavigationBar(
                        
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor:Theme.of(context).accentColor,
                        currentIndex: currentIndex,
                        items: myTabs,
                        onTap: (index){
                          if (this.mounted) {
                            setState(() {
                                currentIndex = index;
                                currenPage = tabBodies[currentIndex];
                                _setMyTabsData();
                                appBarTitle = tabData[currentIndex]['text'];
                            });
                          } 
                        },
                    ),
      ),
        //tabbarview+tabbar
      // body: new TabBarView(
      //   //不可滑动
      //   physics: NeverScrollableScrollPhysics(),
      //   controller: controller,
      //   children: <Widget>[
      //     FirstPage(),
      //     RemoteDoorPage(),
      //     WisdomPartyBuildingPage(),
      //   ],
      // ),
      // bottomNavigationBar: Material(
      //   color: Colors.white,
      //   child: SafeArea(
      //     child: Container(
      //       height: 65.0,
            // decoration: BoxDecoration(//阴影
            //   color: Colors.white,
            //   boxShadow: <BoxShadow>[
            //     BoxShadow(
            //       color: const Color(0xFFededed),
            //       blurRadius: 6.0,
            //       //spreadRadius: 2.0,
            //       offset: Offset(0, -3.0),
            //     ),
            //   ],
            // ),
      //       child: TabBar(//下面的tabbar
      //           controller: controller,
      //           //tab标签的下划线颜色
      //           indicatorColor: Colors.transparent,
      //           isScrollable: false,
                
      //           // labelColor: const Color(0xFF000000),
      //           //indicatorWeight: 3.0,
      //           //labelcolor 选中的
      //           labelColor: Theme.of(context).accentColor,
      //           //labelColor: Colors.green,
      //           unselectedLabelColor: const Color(0xFF8E8E8E),
      //           tabs: myTabs),
      //     ),
      //   ),
      // ),
    );
  }
}