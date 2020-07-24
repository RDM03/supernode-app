import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/page/home_page/gateway_component/action.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'state.dart';

Widget buildView(GatewayItemState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Container(
    height: 100,
    padding: const EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color.fromARGB(26, 0, 0, 0),
          width: 1
        )
      ),
    ),
    child: ListTile(
      onTap: () => dispatch(GatewayActionCreator.onProfile(state)),
      title: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 90,
                padding: kOuterRowTop10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5,top: 4),
                      child: Icon(
                        Icons.lens,
                        color: TimeDao.isIn5Min(state.lastSeenAt) ? Colors.green : Colors.grey,
                        size: 10,
                      ),
                    ),
                    Text(
                      TimeDao.isIn5Min(state.lastSeenAt) ?
                      '(${FlutterI18n.translate(_ctx,'online')})' : '(${FlutterI18n.translate(_ctx,'offline')})',
                      style: kSmallFontOfGrey
                    ),
                  ],
                ),
              ),
              Padding(
                padding: kOuterRowTop5,
                child: Text(
                  state.name,
                  textAlign: TextAlign.left,
                  style: kBigFontOfBlack
                )
              ),
              Padding(
                padding: kOuterRowTop5,
                child: Text(
                  '${FlutterI18n.translate(_ctx,'last_seen')}: ${TimeDao.getDatetime(state.lastSeenAt)}',
                  style: kSmallFontOfGrey,
                ),
              )
            ],
          ),
          Spacer(),
          Container(
            alignment: Alignment.centerRight,
            margin: kOuterRowTop20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${FlutterI18n.translate(_ctx,'downlink_price')}',
                  style: kSmallFontOfGrey,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(51, 77, 137, 229),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(
                    '${state.location["accuracy"]} MXC',
                    style: kBigFontOfBlack,
                  ),
                ),
              ]
            )
          )
        ]
      ),
    ),
  );
}
