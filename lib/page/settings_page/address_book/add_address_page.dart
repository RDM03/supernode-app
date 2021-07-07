import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/scan_qr.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'address_book_page.dart';

class AddAddressPage extends StatefulWidget {
  final AddressBookType type;
  const AddAddressPage({Key key, this.type = AddressBookType.mxc})
      : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  Future<void> _onQr() async {
    String qrResult = await scanQR(context);
    addressController.text = qrResult;
  }

  Future<void> _onSave() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    final addresses = widget.type == AddressBookType.mxc
        ? context.read<StorageRepository>().addressBook()
        : context.read<StorageRepository>().dhxAddressBook();
    addresses.add(AddressEntity(
      address: addressController.text,
      memo: memoController.text,
      name: nameController.text,
    ));
    if (widget.type == AddressBookType.mxc)
      await context.read<StorageRepository>().setAddressBook(addresses);
    else
      await context.read<StorageRepository>().setDhxAddressBook(addresses);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      scrollable: false,
      useSafeArea: true,
      children: [
        PageNavBar(
          text: widget.type.token.name +
              ' ' +
              FlutterI18n.translate(context, 'address_book'),
          leadingWidget: AppBarBackButton(),
          actionWidget: Icon(Icons.center_focus_weak),
          onTap: _onQr,
          centerTitle: true,
        ),
        bigColumnSpacer(),
        Form(
          key: formKey,
          child: Column(children: <Widget>[
            Container(
              child: Text(
                FlutterI18n.translate(context, 'address_book_desc'),
                style: TextStyle(
                  color: greyColorShade600,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextFieldWithTitle(
              key: ValueKey('addressTextField'),
              title: FlutterI18n.translate(context, 'address'),
              validator: (v) => v != null &&
                      (widget.type == AddressBookType.dhx ||
                          isValidEthereumAddress(v))
                  ? null
                  : FlutterI18n.translate(context, 'invalid_address'),
              controller: addressController,
            ),
            smallColumnSpacer(),
            TextFieldWithTitle(
              key: ValueKey('nameTextField'),
              title: FlutterI18n.translate(context, 'name'),
              validator: (v) => v != null && v.isNotEmpty
                  ? null
                  : FlutterI18n.translate(context, 'invalid_name'),
              controller: nameController,
            ),
            smallColumnSpacer(),
            TextFieldWithTitle(
              key: ValueKey('memoTextField'),
              title: FlutterI18n.translate(context, 'memo'),
              controller: memoController,
            ),
          ]),
        ),
        Spacer(),
        PrimaryButton(
          buttonTitle: FlutterI18n.translate(context, 'update'),
          onTap: _onSave,
          minWidth: double.infinity,
          minHeight: 48,
          bgColor: widget.type.token.color,
          key: ValueKey('updateButton'),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
