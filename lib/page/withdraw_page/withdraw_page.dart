import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/security/bitcoin_utils.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/withdraw_page/WithdrawSecurityCode.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'WithdrawConfirm.dart';
import 'bloc/cubit.dart';

class WithdrawPage extends StatefulWidget {
  final Token token;

  WithdrawPage(this.token);

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  Loading loading;

  get feeCurrency => (widget.token == Token.btc) ? Token.mxc.name: widget.token.name;

  @override
  void initState() {
    context.read<WithdrawCubit>().withdrawFee(widget.token);
    context.read<WithdrawCubit>().requestTOTPStatus();
    super.initState();
  }

  @override
  void dispose() {
    amountCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WithdrawCubit, WithdrawState>(
          listenWhen: (a, b) => a.showLoading != b.showLoading,
          listener: (ctx, state) async {
            loading?.hide();
            if (state.showLoading) {
              loading = Loading.show(ctx);
            }
          },
        ),
        BlocListener<WithdrawCubit, WithdrawState>(
          listenWhen: (a, b) => a.withdrawFlowStep != b.withdrawFlowStep,
          listener: (ctx, state) async {
            if(state.withdrawFlowStep == WithdrawFlow.finish) {
              Navigator.pushReplacementNamed(context, 'confirm_page', arguments: {
                'title': 'withdraw',
                'content': 'withdraw_submit_tip'
              });
            }
          },
        ),
        BlocListener<WithdrawCubit, WithdrawState>(
          listenWhen: (a, b) => a.address != b.address,
          listener: (context, s) => addressCtrl.text = s.address,
        )],
      child: BlocBuilder<WithdrawCubit, WithdrawState>(
        buildWhen: (a, b) => a.withdrawFlowStep != b.withdrawFlowStep,
        builder: (ctx, st) {
          if (st.withdrawFlowStep == WithdrawFlow.form)
            return Scaffold(
                appBar: AppBars.backArrowAndActionAppBar(
                  title: FlutterI18n.translate(context, 'withdraw'),
                  onPress: () => Navigator.pop(context),
                  action: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () async {
                        String qrResult = await MajaScan.startScan(
                            title: FlutterI18n.translate(context,
                                'scan_code'),
                            barColor: buttonPrimaryColor,
                            titleColor: backgroundColor,
                            qRCornerColor: buttonPrimaryColor,
                            qRScannerColor: buttonPrimaryColorAccent);
                        context.read<WithdrawCubit>().setAddress(qrResult);
                      },
                      child: Icon(
                          Icons.center_focus_weak,
                          color: Colors.black,
                          size: 30),
                    ),
                  ),
                ),
                backgroundColor: backgroundColor,
                body: PageBody(children: [
                  smallColumnSpacer(),
                  Text(FlutterI18n.translate(context, '24hours_warning'),
                      style: kBigFontOfBlack),
                  smallColumnSpacer(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        smallColumnSpacer(),
                        Image.asset(widget.token.imagePath),
                        Text(widget.token.name),
                        smallColumnSpacer(),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FlutterI18n.translate(
                                      context, 'current_balance'),
                                  style: kMiddleFontOfBlack,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: borderColor,
                                      ),
                                    ),
                                  ), //child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                                  child: _balanceWidget(),
                                ),
                                smallColumnSpacer(),
                                TextFieldWithTitle(
                                  title: FlutterI18n.translate(
                                      context, 'withdraw_amount'),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) =>
                                      _onValidAmount(context, value),
                                  controller: amountCtrl,
                                ),
                                smallColumnSpacer(),
                                TextFieldWithTitle(
                                    title: FlutterI18n.translate(
                                        context, 'send_to_address'),
                                    textInputAction: TextInputAction.next,
                                    validator: (address) =>
                                        _onValidateAddress(address),
                                    controller: addressCtrl,
                                    suffixChild: IconButton(
                                        icon: Icon(Icons.assignment_ind, color: widget.token.color),
                                        onPressed: () async {
                                          final res = await Navigator.of(context).pushNamed(
                                            'address_book_page',
                                            arguments: {'selection': true},
                                          );
                                          if (res == null) return;
                                          if (res is AddressEntity)
                                            context.read<WithdrawCubit>().setAddress(res.address);
                                        }
                                    )
                                ),
                                middleColumnSpacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center,
                                  children: [
                                    Text(
                                      FlutterI18n.translate(
                                          context, 'current_transaction_fee'),
                                      textAlign: TextAlign.left,
                                      style: kSmallFontOfGrey,
                                    ),
                                    SizedBox(width: s(5)),
                                    GestureDetector(
                                      onTap: () => _showInfoDialog(),
                                      child: Image.asset(
                                          AppImages.questionCircle,
                                          height: s(20)),
                                    ),
                                    Spacer(),
                                    BlocBuilder<WithdrawCubit, WithdrawState>(
                                        buildWhen: (a, b) => a.fee != b.fee,
                                        builder: (ctx, state) =>
                                            Text('${state.fee ??
                                                '--'} $feeCurrency',
                                                style: kBigFontOfBlack)),
                                  ],
                                ),
                                smallColumnSpacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: shodowColor,
                          offset: Offset(0, 2),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                  ),
                  bigColumnSpacer(),
                  PrimaryButton(
                      buttonTitle: FlutterI18n.translate(
                          context, 'request_withdraw'),
                      bgColor: widget.token.color,
                      onTap: () {
                        if (!formKey.currentState.validate()) return;
                        context.read<WithdrawCubit>().goToConfirmation(
                            double.tryParse(amountCtrl.text),
                            addressCtrl.text.trim());
                      }
                  ),
                ])
            );

          if (st.withdrawFlowStep == WithdrawFlow.confirm)
            return WithdrawConfirm(feeCurrency);

          if (st.withdrawFlowStep == WithdrawFlow.securityCode)
            return WithdrawSecurityCode();

          return SizedBox();
        },
      ),
    );
  }

  String _onValidAmount(BuildContext context, String value) {
    String res = Reg.isEmpty(value);
    if (res != null) return FlutterI18n.translate(context, res);

    final amount = double.tryParse(value);

    if (amount == null || amount <= 0) return FlutterI18n.translate(context, 'reg_amount');

    final fee = context.read<WithdrawCubit>().state.fee??0;

    if (widget.token == Token.mxc || widget.token == Token.supernodeDhx) {
      if (amount + fee > _getBalance(widget.token)) {
        return FlutterI18n.translate(context, 'insufficient_balance');
      }
    }

    if (widget.token == Token.btc) {
      if (amount > _getBalance(widget.token) || fee > _getBalance(Token.mxc)) {
        return FlutterI18n.translate(context, 'insufficient_balance');
      }

      if (amount != double.parse(amount.toStringAsFixed(8))) {
        return FlutterI18n.translate(context, 'amount_8decimal');
      }
    }

    return null;
  }

  String _onValidateAddress(String address) {
    String res = Reg.isEmpty(address);
    if (res != null) return FlutterI18n.translate(context, res);

    dynamic isValidAddress = (_) => true;
    if (widget.token == Token.mxc)
      isValidAddress = isValidEthereumAddress;
    if (widget.token == Token.btc)
      isValidAddress = Bitcoin.isValidBtcAddress;

    if (!isValidAddress(address.trim()))
      return FlutterI18n.translate(context, 'invalid_address');

    return null;
  }

  void _showInfoDialog() {
    showInfoDialog(
      context,
      IosStyleBottomDialog2(
        builder: (context) =>
            Column(
              children: [
                Image.asset(AppImages.infoCurrentTransactionFee, height: s(80)),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      FlutterI18n.translate(
                          context, 'info_current_transaction_fee'),
                      key: ValueKey('helpText'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: s(16),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
      ),
    );
  }

  Widget _balanceWidget() {
    if  (widget.token == Token.mxc)
      return BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
        buildWhen: (a, b) => a.balance != b.balance,
        builder: (ctx, state) => Text('${Tools.priceFormat(state.balance.value)} ${widget.token.name}', style: kBigFontOfBlack),
      );
    if  (widget.token == Token.supernodeDhx)
      return BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
        buildWhen: (a, b) => a.balance != b.balance,
        builder: (ctx, state) => Text('${Tools.priceFormat(state.balance.value)} ${widget.token.name}', style: kBigFontOfBlack),
      );
    if  (widget.token == Token.btc)
      return BlocBuilder<SupernodeBtcCubit, SupernodeBtcState>(
        buildWhen: (a, b) => a.balance != b.balance,
        builder: (ctx, state) => Text('${Tools.priceFormat(state.balance.value, range: 8)} ${widget.token.name}', style: kBigFontOfBlack),
      );

    return SizedBox();
  }

  double _getBalance(Token token) {
    if  (token == Token.mxc)
      return context.read<SupernodeUserCubit>().state.balance.value;
    if  (token == Token.supernodeDhx)
      return context.read<SupernodeDhxCubit>().state.balance.value;
    if  (token == Token.btc)
      return context.read<SupernodeBtcCubit>().state.balance.value;

    return 0;
  }
}