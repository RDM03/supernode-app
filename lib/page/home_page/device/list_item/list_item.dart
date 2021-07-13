import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class DeviceListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: shodowColor,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, 'device_mapbox_page',
              arguments: {'isDemo': context.read<AppState>().isDemo});
        },
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.lens,
                    color: true ? Colors.green : greyColor,
                    size: 10,
                  ),
                  SizedBox(width: 5),
                  Text(
                      true
                          ? '(${FlutterI18n.translate(context, 'online')})'
                          : '(${FlutterI18n.translate(context, 'offline')})',
                      style: FontTheme.of(context).small.secondary()),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.watch,
                          size: 24,
                        ),
                        SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            'LPWAN watch',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: FontTheme.of(context).big(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    FlutterI18n.translate(context, 'downlink_fee'),
                    style: FontTheme.of(context).big.secondary(),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${FlutterI18n.translate(context, 'last_seen')}: 2020-05-19 09:39:12',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FontTheme.of(context).small.secondary(),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: dbm115_120,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Text(
                      '10 MXC',
                      style: FontTheme.of(context).big(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
