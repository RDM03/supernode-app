import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/page/home_page/user/tabbed_view.dart';

class AccountWidget extends StatelessWidget {
  Widget supernode(BuildContext context) => Column(
        children: [
          BlocBuilder<SupernodeCubit, SupernodeState>(
            buildWhen: (a, b) => a?.session?.username != b?.session?.username,
            builder: (ctx, state) => ProfileRow(
              keyTitle: ValueKey('mxcProfile'),
              keySubtitle: ValueKey('mxcProfileSubtitle'),
              name: state?.session?.username,
              position: 'Supernode Server',
              trailing: SizedBox(
                width: 30,
              ),
            ),
          ),
        ],
      );

  Widget parachain(BuildContext context) => Container(
        color: Token.parachainDhx.ui(context).color,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (a, b) =>
          a.parachainUsed != b.parachainUsed ||
          a.supernodeUsed != b.supernodeUsed,
      builder: (ctx, state) => TabbedView(
        contentHeight: 75,
        tabs: [
          if (state.supernodeUsed)
            ColorCodedWidget(
                supernode(context), Token.supernodeDhx.ui(context).color),
          if (state.parachainUsed)
            ColorCodedWidget(
                parachain(context), Token.parachainDhx.ui(context).color),
        ],
      ),
    );
  }
}
