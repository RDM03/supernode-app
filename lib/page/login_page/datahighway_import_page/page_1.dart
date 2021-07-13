import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/picker_card.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/login_page/datahighway_import_page/page_2.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';

class DataHighwayImportPage extends StatefulWidget {
  @override
  _DataHighwayImportPageState createState() => _DataHighwayImportPageState();
}

enum SourceType { mnemonic, rawSeed, keystore, observation }

class _DataHighwayImportPageState extends State<DataHighwayImportPage> {
  SourceType importType = SourceType.mnemonic;

  // mnemonic
  TextEditingController mnemonicController = TextEditingController();

  // raw seed
  TextEditingController rawSeedController = TextEditingController();

  // keystore
  TextEditingController keystoreController = TextEditingController();
  TextEditingController keystoreNameController = TextEditingController();
  TextEditingController keystorePasswordController = TextEditingController();

  // observation
  TextEditingController dhxAddressController = TextEditingController();
  TextEditingController dhxNameController = TextEditingController();
  TextEditingController dhxMemoController = TextEditingController();

  @override
  void dispose() {
    mnemonicController.dispose();
    rawSeedController.dispose();
    keystoreController.dispose();
    keystoreNameController.dispose();
    keystorePasswordController.dispose();
    super.dispose();
  }

  Widget textField(String title, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        decoration: InputDecoration(
          hintText: title,
          labelText: title,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Token.parachainDhx.ui(context).color),
          ),
        ),
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAppBar(
        context,
        color: whiteColor,
        title: 'Import Account',
        onPress: () => Navigator.of(context).pop(),
      ),
      backgroundColor: whiteColor,
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Token.parachainDhx.ui(context).color,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  PickerCard<SourceType>(
                    margin: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    label: 'Source Type',
                    onValueSelected: (SourceType val, i) {
                      setState(() {
                        importType = val;
                      });
                    },
                    stringifier: (e) {
                      switch (e) {
                        case SourceType.mnemonic:
                          return 'Mnemonic';
                        case SourceType.rawSeed:
                          return 'Raw Seed';
                        case SourceType.keystore:
                          return 'Keystore';
                        case SourceType.observation:
                          return 'Observation';
                      }
                      return 'Unknown';
                    },
                    values: SourceType.values,
                    defaultValue: SourceType.mnemonic,
                  ),
                  if (importType == SourceType.mnemonic)
                    textField('Mnemonic', mnemonicController),
                  if (importType == SourceType.rawSeed)
                    textField('Raw Seed', rawSeedController),
                  if (importType == SourceType.keystore) ...[
                    textField('Keystore', keystoreController),
                    SizedBox(height: 8),
                    textField('Name', keystoreNameController),
                    SizedBox(height: 8),
                    textField('Password', keystorePasswordController),
                  ],
                  if (importType == SourceType.observation) ...[
                    textField('DHX Address', dhxAddressController),
                    SizedBox(height: 8),
                    textField('Name', dhxNameController),
                    SizedBox(height: 8),
                    textField('Memo', dhxMemoController),
                  ],
                ],
              ),
            ),
            SizedBox(
              height: 46,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrimaryButton(
                  bgColor: Token.parachainDhx.ui(context).color,
                  buttonTitle: 'Next',
                  onTap: () => Navigator.of(context)
                      .push(route((ctx) => DataHighwayImport2Page())),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
