import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'address_details_page.dart';
import 'add_address_page.dart';

enum AddressBookType { dhx, mxc }

extension AddressBookTypeExt on AddressBookType {
  Token get token {
    switch (this) {
      case AddressBookType.dhx:
        return Token.supernodeDhx;
      case AddressBookType.mxc:
        return Token.mxc;
      default:
        throw Exception('Uknown token');
    }
  }
}

class AddressBookPage extends StatefulWidget {
  final bool selectionMode;
  final AddressBookType type;

  const AddressBookPage({
    Key key,
    this.selectionMode = false,
    this.type = AddressBookType.mxc,
  }) : super(key: key);

  @override
  _AddressBookPageState createState() => _AddressBookPageState();
}

class _AddressBookPageState extends State<AddressBookPage> {
  List<AddressEntity> addresses;

  @override
  void initState() {
    super.initState();
    reloadAddresses();
  }

  void reloadAddresses() {
    addresses = widget.type == AddressBookType.mxc
        ? context.read<StorageRepository>().addressBook()
        : context.read<StorageRepository>().dhxAddressBook();
  }

  Future<void> _onAdd() async {
    await Navigator.of(context)
        .push(route((_) => AddAddressPage(type: widget.type)));
    setState(() => reloadAddresses());
  }

  Future<void> _onSelect(AddressEntity entity) async {
    if (widget.selectionMode) {
      Navigator.of(context).pop(entity);
    } else {
      await _openDetails(entity);
    }
  }

  Future<void> _openDetails(AddressEntity entity) async {
    await Navigator.of(context).push(
        route((_) => AddressDetailsPage(entity: entity, type: widget.type)));
    setState(() => reloadAddresses());
  }

  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      scrollable: false,
      useSafeArea: true,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: 20),
        PageNavBar(
          text: widget.type.token.ui(context).name +
              ' ' +
              FlutterI18n.translate(context, 'address_book'),
          padding: EdgeInsets.symmetric(horizontal: 20),
          onTap: _onAdd,
          actionWidget: Icon(
            Icons.add,
            color: ColorsTheme.of(context).textPrimaryAndIcons,
            size: 28,
          ),
          leadingWidget: AppBarBackButton(),
          centerTitle: true,
        ),
        bigColumnSpacer(),
        Expanded(
          flex: 1,
          child: CustomScrollView(
            key: ValueKey('addressesScrollView'),
            slivers: [
              if (addresses.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(FlutterI18n.translate(context, 'no_data')),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => Container(
                      child: ListTile(
                        key: ValueKey('address_$i'),
                        title: Text(addresses[i].name),
                        onTap: () => _onSelect(addresses[i]),
                        subtitle: GestureDetector(
                          key: ValueKey('address_${i}_details'),
                          child: Text(
                            Tools.hideHalf(addresses[i].address),
                            style: widget.selectionMode
                                ? FontTheme.of(context).small.label.underline()
                                : FontTheme.of(context).small.label(),
                          ),
                          onTap: () => _openDetails(addresses[i]),
                        ),
                        trailing: Icon(
                          widget.selectionMode
                              ? Icons.arrow_forward_ios
                              : Icons.more_vert,
                          color: ColorsTheme.of(context).textPrimaryAndIcons,
                        ),
                        contentPadding: EdgeInsets.only(left: 16, right: 10),
                      ),
                    ),
                    childCount: addresses.length,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
