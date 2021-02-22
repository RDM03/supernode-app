import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/page/home_page/user/tabbed_view.dart';

class AccountWidget extends StatelessWidget {
  Widget supernode(BuildContext context) => Column(
        children: [
          SizedBox(height: 16),
          BlocBuilder<SupernodeCubit, SupernodeState>(
            buildWhen: (a, b) => a?.session?.node != b?.session?.node,
            builder: (ctx, state) => CachedNetworkImage(
              imageUrl: state?.session?.node?.logo ?? '',
              placeholder: (a, b) => Image.asset(
                AppImages.placeholder,
                height: s(40),
              ),
              height: s(40),
            ),
          ),
          SizedBox(height: 18),
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
        color: Colors.green,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (a, b) =>
          a.parachainUsed != b.parachainUsed ||
          a.supernodeUsed != b.supernodeUsed,
      builder: (ctx, state) => TabbedView(
        contentHeight: 150,
        tabs: [
          if (state.supernodeUsed) supernode(context),
          if (state.parachainUsed) parachain(context),
        ],
        tabsColors: [
          if (state.supernodeUsed) Token.supernodeDhx.color,
          if (state.parachainUsed) Token.parachainDhx.color,
        ],
      ),
    );
  }
}
