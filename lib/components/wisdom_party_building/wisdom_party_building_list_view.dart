import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:giant_property/main.dart';
import 'package:giant_property/routers/application.dart';
import 'package:giant_property/routers/routers.dart';
import 'package:giant_property/model/wisdom_party_building/wisdom_party_building_list_model.dart';
import 'package:giant_property/utils/shared_preferences/shared_preferences_keys.dart';
import 'package:giant_property/utils/shared_preferences/shared_preferences.dart';

class WisdomPartyBuildingListView extends StatelessWidget{
  final WisdomPartyBuildingListModel model;
  WisdomPartyBuildingListView(this.model);
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        final String url = 'http://mptest.cngiantech.com:80/gv/${model.id}?token=${sp.getString(SharedPreferencesKeys.token)}';
        print(url);
        Application.router.navigateTo(context, '${Routers.webViewPage}?title=${Uri.encodeComponent(model.title)}&url=${Uri.encodeComponent(url)}',transition: TransitionType.inFromRight);
      },
      child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.title,
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 12,
            ),
            RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: model.body,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(model.createdAt,
              style: Theme.of(context).textTheme.body2,
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
          ],
        ),
      ),
    ),
    );
  }
}