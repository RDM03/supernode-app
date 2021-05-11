import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/address_book_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'state.dart';

Widget buildView(
    AddressBookState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: SafeArea(
      key: Key('AddressBookPage'),
      child: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 239, 242),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(_ctx).size.height - 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(26, 0, 0, 0),
                offset: Offset(0, 2),
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: pageNavBar(
                  FlutterI18n.translate(_ctx, 'address_book'),
                  onTap: () => dispatch(
                    AddressBookActionCreator.onAdd(),
                  ),
                  actionWidget: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 28,
                  ),
                  leadingWidget: GestureDetector(
                    key: ValueKey('navBackButton'),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onTap: () => Navigator.of(_ctx).pop(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                flex: 1,
                child: CustomScrollView(
                  key: ValueKey('addressesScrollView'),
                  slivers: [
                    if (state.addresses == null)
                      SliverFillRemaining()
                    else if (state.addresses.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: Text(FlutterI18n.translate(_ctx, 'no_data')),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => Container(
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                  color: Colors.grey[200],
                                  width: 1,
                                ),
                              ),
                            ),
                            child: ListTile(
                              key: ValueKey('address_$i'),
                              title: Text(state.addresses[i].name),
                              subtitle: GestureDetector(
                                key: ValueKey('address_${i}_details'),
                                child: Text(
                                  Tools.hideHalf(state.addresses[i].address),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: hintFont,
                                    decoration: state.selectionMode
                                        ? TextDecoration.underline
                                        : null,
                                  ),
                                ),
                                onTap: () => dispatch(
                                        AddressBookActionCreator.onDetails(
                                            state.addresses[i]))
                              ),
                              trailing: IconButton(
                                key: ValueKey('address_${i}_buttons'),
                                icon: Icon(
                                  state.selectionMode
                                      ? Icons.arrow_forward_ios
                                      : Icons.more_vert,
                                  color: Colors.black,
                                ),
                                onPressed: () => dispatch(
                                    AddressBookActionCreator.onSelect(
                                        state.addresses[i])),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 10),
                            ),
                          ),
                          childCount: state.addresses.length,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
