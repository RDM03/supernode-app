import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/state.dart';
import 'package:supernodeapp/page/home_page/shared.dart';

class BtcActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        BlocBuilder<SupernodeBtcCubit, SupernodeBtcState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => CircleButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Token.btc.ui(context).color,
            ),
            label: FlutterI18n.translate(context, 'withdraw'),
            onTap: state.balance.loading
                ? null
                : () => openSupernodeWithdraw(context, Token.btc),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
