import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/page/settings_page/address_book/address_book_page.dart';
import 'package:supernodeapp/route.dart';

class AddressBookPicker extends StatelessWidget {
  const AddressBookPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (a, b) => a.displayTokens != b.displayTokens,
      builder: (ctx, state) {
        return pageFrame(
          context: context,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            SizedBox(height: 20),
            PageNavBar(
              text: FlutterI18n.translate(context, 'address_book'),
              padding: EdgeInsets.symmetric(horizontal: 20),
              leadingWidget: AppBarBackButton(),
              actionWidget: null,
              centerTitle: true,
            ),
            SizedBox(height: 33),
            if (state.displayTokens.contains(Token.mxc)) ...[
              Divider(height: 1),
              listItem(
                Token.mxc.ui(context).name,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                key: Key('mxc_button'),
                onTap: () => Navigator.push(
                  context,
                  routeWidget(AddressBookPage(
                        type: AddressBookType.mxc,
                      )),
                ),
                leading: Image(
                  image: Token.mxc.ui(context).image,
                  height: s(50),
                ),
              ),
            ],
            if (state.displayTokens.contains(Token.supernodeDhx)) ...[
              Divider(height: 1),
              listItem(
                Token.supernodeDhx.ui(context).name,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                key: Key('dhx_button'),
                onTap: () => Navigator.push(
                  context,
                  routeWidget(AddressBookPage(
                        type: AddressBookType.dhx,
                      )),
                ),
                leading: Image(
                  image: Token.supernodeDhx.ui(context).image,
                  height: s(50),
                ),
              )
            ],
            Divider(height: 1),
          ],
        );
      },
    );
  }
}
