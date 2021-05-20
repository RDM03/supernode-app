import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/dd_body.dart';
import 'package:supernodeapp/common/components/page/dd_box_spacer.dart';
import 'package:supernodeapp/common/components/page/dd_box_with_select.dart';
import 'package:supernodeapp/common/components/page/dd_dot_text.dart';
import 'package:supernodeapp/common/components/page/dd_icon_with_titles.dart';
import 'package:supernodeapp/common/components/page/dd_nav.dart';
import 'package:supernodeapp/common/components/page/dd_result_failure.dart';
import 'package:supernodeapp/common/components/page/dd_result_success.dart';
import 'package:supernodeapp/common/components/page/dd_result_warning.dart';
import 'package:supernodeapp/common/components/page/dd_subtitle.dart';
import 'package:supernodeapp/common/components/page/dd_textfield_with_label.dart';
import 'package:supernodeapp/common/components/page/dd_title_with_switch.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/gateway/bloc/cubit.dart';
import 'package:supernodeapp/page/home_page/gateway/bloc/state.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/spacing.dart';

class MinerProfileSettingPage extends StatefulWidget {
  final String serialNumer;

  const MinerProfileSettingPage({
    Key key,
    @required this.serialNumer,
  }): super(key: key);

   @override
  _MinerProfileSettingPageState createState() => _MinerProfileSettingPageState();
}

class _MinerProfileSettingPageState extends State<MinerProfileSettingPage> {
  Loading loading;
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController descriptionCtl = TextEditingController();
  TextEditingController idCtl = TextEditingController();
  TextEditingController altitudeCtl = TextEditingController();

  @override
  void initState() {
    context.read<MinerCubit>().networkServerList();
    // nameCtl.text = context.read<MinerState>().serialNumber;
    // emit(state.copyWith(serialNumber:'22'));
    super.initState();
  }

  @override
  void dispose() {
    nameCtl.dispose();
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
          listenWhen: (a, b) => a.addMinerFlowStep != b.addMinerFlowStep,
          listener: (ctx, state) async {
            if (state.addMinerFlowStep == AddMinerFlow.success) {
              Navigator.push(ctx,
                route((_) => DDResultSuccss())
              ).then((_) async {
                await ctx.read<GatewayCubit>().refresh();
                Navigator.of(ctx).pop();
              });
            } else if (state.addMinerFlowStep == AddMinerFlow.failure) {
              Navigator.push(ctx,
                route((_) => DDResultFailure(detail: state.message)),
              );
            } else if (state.addMinerFlowStep == AddMinerFlow.warning) {
              Navigator.push(ctx,
                route((_) => DDResultWarning(detail: state.message)),
              );
            }
          },
        ),
      ],  
      child: DDBody(
        child: Form(
          key: formKey,
          child: ListView( 
            children: [
              DDNav(
                title: 'add_miner',
                hasBack: true,
              ),
              DDIconWithTitles(
                imageUrl: AppImages.gateways,
                title: 'Miner Profile Setting',
                subtitle: 'Serial number here',
              ),
              BlocBuilder<MinerCubit, MinerState>(
                buildWhen: (a, b) => a.networkServerName != b.networkServerName,
                builder: (ctx, state) {
                  return DDBoxWithSelect(
                    title: 'network_server',
                    subtitle: state.networkServerName ?? 
                        'Select the network-server to which the M2 Pro Miner will connect.',
                    onTap: () async => await ctx.read<MinerCubit>().networkServerPicker(ctx),
                  );
                }
              ),
              DDDotText(
                text: 'network_server_tip',
              ),
              DDBoxSpacer(),
              BlocBuilder<MinerCubit, MinerState>(
                buildWhen: (a, b) => a.minerProfileName != b.minerProfileName,
                builder: (ctx, state) {
                  return DDBoxWithSelect(
                    title: 'smb_gateway_profile',
                    subtitle: state.minerProfileName ?? 'An option Miner-Profile may be assigned to a Miner.',
                    onTap: () => ctx.read<MinerCubit>().gatewayProfilePicker(ctx),
                  );
                }
              ),
              DDDotText(
                text: 'gateway_profile_tip',
              ),
              DDBoxSpacer(height: SpacerStyle.medium),
              DDTextfieldWithLabel(
                label: 'gateway_name',
                hintText: 'MINER-DEFAULT-Name',
                initialValue: widget.serialNumer,
                readOnly: true,
                validator: (value) => Reg.onNotEmpty(context, value),
                // controller: nameCtl,
              ),
              DDSubtitle('The name may only contain words, numbers and dashes.'),
              DDBoxSpacer(),
              DDTextfieldWithLabel(
                label: 'gateway_description',
                validator: (value) => Reg.onNotEmpty(context, value),
                controller: descriptionCtl
              ),
              DDBoxSpacer(),
              DDTextfieldWithLabel(
                label: 'gateway_id',
                validator: (value) => Reg.onNotEmpty(context, value),
                controller: idCtl
              ),
              DDBoxSpacer(),
              BlocBuilder<MinerCubit, MinerState>(
                buildWhen: (a, b) => a.discoveryEnabled != b.discoveryEnabled,
                builder: (ctx, state) {
                  return DDTitleWithSwitch(
                    title: 'discovery_enabled',
                    value: state.discoveryEnabled,
                    onChange: (value) => ctx.read<MinerCubit>().changeDiscoveryEnabled(value)
                  );
                }
              ),
              DDSubtitle('When enabled (and LPWAN Server is configured with the M2 Pro Miner discover feature enabled), the M2 Pro Miner will send out periodical pings to test its coverage by other M2 Pro Miner or gateways in the same network.'),
              DDBoxSpacer(),
              DDTextfieldWithLabel(
                label: 'gateway_altitude',
                validator: (value) => Reg.onNotEmpty(context, value),
                controller: altitudeCtl,
              ),
              DDSubtitle('When the M2 Pro Miner has an on-board GPS, this value will be set automatically when the network has received statistics from the M2 Pro Miner.'),
              DDBoxSpacer(height: SpacerStyle.medium),
              BlocBuilder<MinerCubit, MinerState>(
                builder: (ctx, state) {
                  return PrimaryButton(
                    padding: kRoundRow1005,
                    minWidth: double.infinity,
                    minHeight: s(40),
                    buttonTitle: FlutterI18n.translate(ctx, 'confirm'),
                    onTap: () async {
                      if (state.networkServerId == null || state.networkServerId.isEmpty) {
                        tip(FlutterI18n.translate(ctx, 'reg_network_server'));
                        return;
                      }

                      if (state.minerProfileId == null || state.minerProfileId.isEmpty) {
                        tip(FlutterI18n.translate(ctx, 'reg_gateway_profile'));
                        return;
                      }

                      if (!formKey.currentState.validate()) return;

                      ctx.read<MinerCubit>().submitProfileSetting(
                        networkServerId: state.networkServerId,
                        minerProfileId: state.minerProfileId,
                        name: nameCtl.text,
                        description: descriptionCtl.text,
                        id: idCtl.text,
                        discoveryEnabled: state.discoveryEnabled,
                        altitude: altitudeCtl.text
                      );
                    }
                  );
                }
               )
            ]
          )
        )
      )
    );
  }

}

