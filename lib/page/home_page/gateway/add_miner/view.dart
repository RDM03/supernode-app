import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/dd_body.dart';
import 'package:supernodeapp/common/components/page/dd_box_spacer.dart';
import 'package:supernodeapp/common/components/page/dd_box_with_shadow.dart';
import 'package:supernodeapp/common/components/page/dd_icon.dart';
import 'package:supernodeapp/common/components/page/dd_icon_with_shadow.dart';
import 'package:supernodeapp/common/components/page/dd_nav.dart';
import 'package:supernodeapp/common/components/page/dd_nav_with_skip.dart';
import 'package:supernodeapp/common/components/page/dd_result_failure.dart';
import 'package:supernodeapp/common/components/page/dd_result_success.dart';
import 'package:supernodeapp/common/components/page/dd_result_warning.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/scan_qr.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/gateway/bloc/cubit.dart';
import 'package:supernodeapp/page/home_page/gateway/bloc/state.dart';
import 'package:supernodeapp/page/home_page/gateway/miner_profile_setting/view.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class AddMinerPage extends StatefulWidget {
  final bool hasSkip;

  const AddMinerPage({Key key, this.hasSkip = false}) : super(key: key);

  @override
  _AddMinerPageState createState() => _AddMinerPageState();
}

class _AddMinerPageState extends State<AddMinerPage> {
  Loading loading;
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController serialNumberCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    serialNumberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<MinerCubit, MinerState>(
            listenWhen: (a, b) => a.showLoading != b.showLoading,
            listener: (ctx, state) async {
              loading?.hide();
              if (state.showLoading) {
                loading = Loading.show(ctx);
              }
            },
          ),
          BlocListener<MinerCubit, MinerState>(
            listenWhen: (a, b) =>
                a.isRegisterResellerSuccess != b.isRegisterResellerSuccess,
            listener: showRegisterResellerSuccess,
          ),
          BlocListener<MinerCubit, MinerState>(
            listenWhen: (a, b) => a.serialNumber != b.serialNumber,
            listener: (ctx, s) => serialNumberCtrl.text = s.serialNumber,
          ),
          BlocListener<MinerCubit, MinerState>(
            listenWhen: (a, b) => a.addMinerFlowStep != b.addMinerFlowStep,
            listener: (ctx, state) async {
              if (state.addMinerFlowStep == AddMinerFlow.setting) {
                Navigator.push(
                    context,
                    route((_) => BlocProvider(
                        create: (ctx) => MinerCubit(
                            context.read<AppCubit>(),
                            context.read<SupernodeRepository>(),
                            context.read<SupernodeCubit>()),
                        child: MinerProfileSettingPage(
                            serialNumer: state.serialNumber))));
              } else if (state.addMinerFlowStep == AddMinerFlow.success) {
                Navigator.push(ctx, route((_) => DDResultSuccss()))
                    .then((_) async {
                  await context.read<GatewayCubit>().refresh();
                });
              } else if (state.addMinerFlowStep == AddMinerFlow.failure) {
                Navigator.push(
                  context,
                  route((_) => DDResultFailure(detail: state.message)),
                );
              } else if (state.addMinerFlowStep == AddMinerFlow.warning) {
                Navigator.push(
                  context,
                  route((_) => DDResultWarning(detail: state.message)),
                );
              }
            },
          ),
        ],
        child: DDBody(
            child: ListView(padding: EdgeInsets.zero, children: [
              widget.hasSkip
                  ? DDNavWithSkip(
                      title: 'add_miner',
                      hasBack: true,
                    )
                  : DDNav(
                      title: 'add_miner',
                      hasClose: true,
                    ),
              Container(
                padding: kRoundRow2010,
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DDIconWithShadow(
                            imageUrl: AppImages.gateways,
                          ),
                          DDBoxSpacer(width: SpacerStyle.medium),
                          Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                    FlutterI18n.translate(context, 'add_miner'),
                                    style: kBigBoldFontOfBlack),
                                Text(
                                  FlutterI18n.translate(
                                      context, 'add_miner_tip'),
                                  style: kMiddleFontOfBlack,
                                )
                              ])),
                        ])
                  ],
                ),
              ),
              DDBoxWithShadow(
                  height: s(110),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.add_circle,
                          color: ColorsTheme.of(context).mxcBlue,
                          size: s(50),
                        ),
                        onPressed: () async {
                          String qrResult = await scanQR(context);

                          context.read<MinerCubit>().setSerialNumber(qrResult);
                          context.read<MinerCubit>().dispathRegister(qrResult);
                        },
                      ),
                      Container(
                          margin: kOuterRowTop10,
                          child: Text(
                            FlutterI18n.translate(context,
                                'scan_qrcode'), //'Scan QR to add Miner'),
                            style: kMiddleFontOfGrey,
                          ))
                    ],
                  )),
              Container(
                  padding: kOuterRowTop10,
                  margin: kRoundRow2005,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                      ),
                      Expanded(
                          child: Form(
                              key: formKey,
                              child: BlocBuilder<MinerCubit, MinerState>(
                                  buildWhen: (a, b) =>
                                      a.textColor != b.textColor,
                                  builder: (ctx, state) {
                                    return TextFormField(
                                        controller: serialNumberCtrl,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) =>
                                            Reg.onNotEmpty(ctx, value),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: FlutterI18n.translate(
                                                context,
                                                'input_serial_number') //'Manually add serial number',
                                            ),
                                        style: MiddleFontOfColor(
                                            color: state.textColor),
                                        onChanged: (value) => ctx
                                            .read<MinerCubit>()
                                            .changeColor(value));
                                  })))
                    ],
                  )),
              BlocBuilder<GatewayCubit, GatewayState>(
                  buildWhen: (a, b) => a.gateways != b.gateways,
                  builder: (ctx, state) => Visibility(
                        visible: state.gateways.value?.isNotEmpty ?? false,
                        child: DDBoxWithShadow(
                            height: 300,
                            child: PaginationView<GatewayItem>(
                              itemBuilder: (BuildContext ctx, GatewayItem state,
                                      int index) =>
                                  Slidable(
                                      key: Key("slide_gateway$index"),
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: DDIcon(
                                                imageUrl: AppImages.gateways,
                                                backgroundColor: lightBlue),
                                            title: Text(
                                              state.name,
                                              style: kBigFontOfBlack,
                                            ),
                                            subtitle: Text(
                                              state.id,
                                              style: kMiddleFontOfBlue,
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      )),
                              pageFetch: (page) async {
                                if (page == 0) return state.gateways.value;
                                return await context
                                    .read<GatewayCubit>()
                                    .loadNextPage(page);
                              },
                              onError: (dynamic error) => Center(
                                child: Text('Some error occured'),
                              ),
                              onEmpty: Empty(),
                            )),
                      )),
            ]),
            floatingActionButton: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: PrimaryButton(
                  padding: kRoundRow2005,
                  minWidth: double.infinity,
                  minHeight: s(40),
                  buttonTitle: FlutterI18n.translate(context, 'confirm'),
                  onTap: () async {
                    if (!formKey.currentState.validate()) return;
                    await context
                        .read<MinerCubit>()
                        .submitSerialNumber(serialNumberCtrl.text);
                  }),
            )));
  }

  void showRegisterResellerSuccess(BuildContext context, MinerState state) {
    showInfoDialog(
      context,
      IosStyleBottomDialog2(
        builder: (context) => Text(
          FlutterI18n.translate(context, 'register_reseller_success')
              .replaceFirst('{0}', state.serialNumber),
          style: kBigFontOfBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
