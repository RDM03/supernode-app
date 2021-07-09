import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/buttons/rounded_button.dart';
import 'package:supernodeapp/common/components/mnemonic_list.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class DataHighwayCreate3Page extends StatefulWidget {
  @override
  _DataHighwayCreate3PageState createState() => _DataHighwayCreate3PageState();
}

class _DataHighwayCreate3PageState extends State<DataHighwayCreate3Page> {
  List<String> _wordsSelected = [];
  static const _mockWords = [
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
  ];
  List<String> _wordsLeft = [..._mockWords];

  Widget _buildWordsButtons() {
    if (_wordsLeft.length > 0) {
      _wordsLeft.sort();
    }

    var perRow = 3;
    var rowsCount = (_wordsLeft.length / perRow).ceil();

    var el = (String i) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: RoundedButton.dense(
              text: i,
              onPressed: () {
                setState(() {
                  _wordsLeft.remove(i);
                  _wordsSelected.add(i);
                });
              },
            ),
          ),
        );

    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          for (var i = 0; i < rowsCount; i++)
            Row(
              children: [
                for (var j = 0; j < perRow; j++)
                  i * perRow + j < _wordsLeft.length
                      ? el(_wordsLeft[i * perRow + j])
                      : Spacer(),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAppBar(
        context,
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
                        'Please click on the mnemonic in the correct order to confirm that the backup is correct',
                        style: kBigFontOfBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 20,
                    ),
                    child: MnemonicList(
                      minHeight: 150,
                      words: _wordsSelected,
                      onClear: () {
                        setState(() {
                          _wordsLeft = [..._mockWords];
                          _wordsSelected = [];
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: _buildWordsButtons(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 46,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrimaryButton(
                  bgColor: Token.parachainDhx.color,
                  buttonTitle: 'Next',
                  onTap: _wordsLeft.isEmpty
                      ? () {
                          context
                              .read<DataHighwayCubit>()
                              .setDataHighwaySession(
                                DataHighwaySession(address: 'mock-account'),
                              );
                          navigatorKey.currentState.pushAndRemoveUntil(
                              route((c) => HomePage()), (_) => false);
                        }
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
