import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/page_content.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AddGatewayState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  
  return state.fromPage == 'home' ? 
    pageFrame(
      context: viewService.context,
      children: _body(
        state: state,
        context: _ctx,
        dispatch: dispatch
      )
    ) :
    Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cardBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          GestureDetector(
            child:  Container(
              alignment: Alignment.center,
              child: Text(
                FlutterI18n.translate(_ctx,'skip'),
                style: kBigFontOfBlack,
              ),
            ),
            onTap:  () => Navigator.of(viewService.context).pushNamedAndRemoveUntil('home_page', (_) => false),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () => Navigator.of(viewService.context).pushNamedAndRemoveUntil('home_page', (_) => false),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: kRoundRow202,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _body(
              state: state,
              context: _ctx,
              dispatch: dispatch
            )
          )
        )
      )
  );
  
}

List<Widget> _body({AddGatewayState state,BuildContext context,Dispatch dispatch}){
    return [
      Visibility(
        visible: state.fromPage != 'home',
        child: paragraph(FlutterI18n.translate(context,'add_gateway_tip')),
      ),
      Visibility(
        visible: state.fromPage == 'home',
        child: pageNavBar(
          FlutterI18n.translate(context,'gateway'),
          onTap: () => Navigator.pop(context)
        ),
      ),
      Visibility(
        visible: state.fromPage == 'home',
        child: introduction(FlutterI18n.translate(context,'add_gateway_tip')),
      ),
      submitButton(
        FlutterI18n.translate(context,'scan_qrcode'),
        top: 20,
        onPressed: () => dispatch(AddGatewayActionCreator.onQrScan())
      ),
      pageContent(
        FlutterI18n.translate(context,'input_serial_number'),
        top: 10
      ),
      Form(
        key: state.formKey,
        child: TextFieldWithTitle(
          title: '',
          key: ValueKey('miner_serial_number'),
          hint: FlutterI18n.translate(context,'serial_number_hint'),
          textInputAction: TextInputAction.done,
          validator: (value) => Reg.onNotEmpty(context, value),     
          controller: state.serialNumberCtl,
        )
      ),
      submitButton(
        FlutterI18n.translate(context,'add_gateway'),
        key: ValueKey('submit_miner'),
        top: 10,
        onPressed: () => dispatch(AddGatewayActionCreator.onProfile())
      ),
    ];
  }
