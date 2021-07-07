import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/settings_page/address_book/address_book_page.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

class AddressDetailsPage extends StatefulWidget {
  final AddressEntity entity;
  final AddressBookType type;

  const AddressDetailsPage(
      {Key key, @required this.entity, @required this.type})
      : super(key: key);

  @override
  _AddressDetailsPageState createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();

  Future<void> _onDelete() async {
    final addresses = widget.type == AddressBookType.mxc
        ? context.read<StorageRepository>().addressBook()
        : context.read<StorageRepository>().dhxAddressBook();
    addresses.remove(widget.entity);
    if (widget.type == AddressBookType.mxc)
      await context.read<StorageRepository>().setAddressBook(addresses);
    else
      await context.read<StorageRepository>().setDhxAddressBook(addresses);
    Navigator.of(context).pop();
  }

  Future<void> _onCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.entity.address));

    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(FlutterI18n.translate(context, 'has_copied'))),
    );
  }

  Widget _titled(String title, String content, {Widget trailing}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kMiddleFontOfBlack,
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  content,
                  style: kMiddleFontOfGrey,
                ),
              ),
              if (trailing != null) trailing,
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageFrame(
      scaffoldKey: scaffoldKey,
      context: context,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: 20),
        PageNavBar(
          text: widget.type.token.name +
              ' ' +
              FlutterI18n.translate(context, 'address_book'),
          padding: EdgeInsets.symmetric(horizontal: 20),
          leadingWidget: AppBarBackButton(),
          actionWidget: null,
          centerTitle: true,
        ),
        bigColumnSpacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            FlutterI18n.translate(context, 'address_book_control_desc'),
            style: TextStyle(
              color: greyColorShade600,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(height: 40),
        _titled(
          FlutterI18n.translate(context, 'address'),
          widget.entity.address,
          trailing: SizedBox(
            width: 30,
            child: IconButton(
              key: ValueKey('copyButton'),
              icon: Icon(Icons.content_copy),
              onPressed: () => _onCopy(),
            ),
          ),
        ),
        middleColumnSpacer(),
        _titled(FlutterI18n.translate(context, 'name'), widget.entity.name),
        if (widget.entity.memo != null && widget.entity.memo.isNotEmpty) ...[
          middleColumnSpacer(),
          _titled(FlutterI18n.translate(context, 'memo'), widget.entity.memo),
        ],
        SizedBox(height: 32),
        GestureDetector(
          key: ValueKey('deleteButton'),
          onTap: _onDelete,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: 62,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: greyColorShade200,
                  width: 1,
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(FlutterI18n.translate(context, 'delete_address'),
                style: kMiddleFontOfRed),
          ),
        )
      ],
    );
  }
}
