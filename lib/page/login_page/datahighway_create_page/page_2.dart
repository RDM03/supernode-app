import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/mnemonic_list.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/login_page/datahighway_create_page/page_3.dart';
import 'package:supernodeapp/page/login_page/datahighway_import_page/page_2.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class DataHighwayCreate2Page extends StatefulWidget {
  @override
  _DataHighwayCreate2PageState createState() => _DataHighwayCreate2PageState();
}

class _DataHighwayCreate2PageState extends State<DataHighwayCreate2Page> {
  bool wordsSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAppBar(
        color: whiteColor,
        title: 'Create Account',
        onPress: () => Navigator.of(context).pop(),
      ),
      backgroundColor: whiteColor,
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Token.parachainDhx.color,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 18),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Backup mnemonic',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Token.parachainDhx.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Use paper and pen to correctly copy mnemonics',
                        style: kBigFontOfBlack,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 25,
                    ),
                    child: MnemonicList(
                      words: [
                        'checkers',
                        'chess',
                        'backgammon',
                        'chapayev',
                        'draughts',
                        'design',
                        'go',
                        'tic-tac-toe',
                        'sea-battle',
                        'dots',
                        'battleships',
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 6),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: wordsSaved,
                onChanged: (v) => setState(() => wordsSaved = v),
                activeColor: Token.parachainDhx.color,
                title: Text(
                  'I wrote it down and put it in a safe place.',
                  style: kMiddleFontOfBlack,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 46,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrimaryButton(
                  bgColor: Token.parachainDhx.color,
                  buttonTitle: 'Next',
                  onTap: wordsSaved
                      ? () => Navigator.of(context)
                          .push(route((ctx) => DataHighwayCreate3Page()))
                      : null,
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
