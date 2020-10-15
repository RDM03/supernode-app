import 'dart:async';
import 'dart:ffi';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/gateway_component/item_state.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    GatewayState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
    appBar: homeBar(
      FlutterI18n.translate(_ctx, 'gateway'),
      onPressed: () => dispatch(HomeActionCreator.onSettings()),
    ),
    body: RefreshIndicator(
      displacement: 10,
      onRefresh: () async {
        dispatch(HomeActionCreator.onGateways());
        await Future.delayed(Duration(seconds: 2));
      },
      child: pageBody(
        useColumn: true,
        children: [
          panelFrame(
            child: panelBody(
              loading: !state.loadingMap.contains('gatewaysTotal'),
              icon: Icons.add_circle,
              onPressed: state.isDemo
                  ? null
                  : () => dispatch(GatewayActionCreator.onAdd()),
              titleText: FlutterI18n.translate(_ctx, 'total_gateways'),
              subtitleText: '${state.gatewaysTotal}',
              trailTitle: FlutterI18n.translate(_ctx, 'profit'),
              trailLoading: !state.loadingMap.contains('gatewaysTotal'),
              trailSubtitle:
                  '${Tools.priceFormat(state.gatewaysRevenue)} MXC (${Tools.priceFormat(state.gatewaysUSDRevenue)} USD)',
            ),
          ),
          Container(
            height: 120 * (state.gatewaysTotal).toDouble(),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(viewService.context).size.height - 305
            ),
            child: panelFrame(
              child: !state.loadingMap.contains('gatewaysTotal')
                  ? LoadingList()
                  : (state.gatewaysTotal != 0
                      ? GatewaysList(
                          dispatch: dispatch,
                          state: state,
                        )
                      : empty(_ctx)),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    ),
  );
}

class GatewaysList extends StatefulWidget {
  final Dispatch dispatch;
  final GatewayState state;

  const GatewaysList({Key key, this.dispatch, this.state}) : super(key: key);

  @override
  _GatewaysListState createState() => _GatewaysListState();
}

class _GatewaysListState extends State<GatewaysList> {
  Dispatch get dispatch => widget.dispatch;
  GatewayState get state => widget.state;

  @override
  Widget build(BuildContext context) {
    return PaginationView<GatewayItemState>(
      itemBuilder: (BuildContext context, GatewayItemState state, int index) =>
          GatewayListTile(
        state: state,
        onTap: () => dispatch(GatewayActionCreator.onProfile(state)),
            onLongPress: () => dispatch(GatewayActionCreator.onDelete(state)),
      ),
      pageFetch: (page) {
        final completer = Completer<List<GatewayItemState>>();
        dispatch(GatewayActionCreator.onLoadPage(page, completer));
        return completer.future;
      },
      onError: (dynamic error) => Center(
        child: Text('Some error occured'),
      ),
      onEmpty: empty(context),
    );
  }
}

class GatewayListTile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final GatewayItemState state;

  GatewayListTile({
    @required this.onTap,
    @required this.onLongPress,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(26, 0, 0, 0), width: 1),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
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
                        padding: const EdgeInsets.only(left: 5, top: 4),
                        child: Icon(
                          Icons.lens,
                          color: TimeDao.isIn5Min(state.lastSeenAt)
                              ? Colors.green
                              : Colors.grey,
                          size: 10,
                        ),
                      ),
                      Text(
                        TimeDao.isIn5Min(state.lastSeenAt)
                            ? '(${FlutterI18n.translate(context, 'online')})'
                            : '(${FlutterI18n.translate(context, 'offline')})',
                        style: kSmallFontOfGrey,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: kOuterRowTop5,
                    child: Text(state.name,
                        textAlign: TextAlign.left, style: kBigFontOfBlack)),
                Padding(
                  padding: kOuterRowTop5,
                  child: Text(
                    '${FlutterI18n.translate(context, 'last_seen')}: ${TimeDao.getDatetime(state.lastSeenAt)}',
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
                    '${FlutterI18n.translate(context, 'downlink_price')}',
                    style: kSmallFontOfGrey,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(51, 77, 137, 229),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Text(
                      '${state.location["accuracy"]} MXC',
                      style: kBigFontOfBlack,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
