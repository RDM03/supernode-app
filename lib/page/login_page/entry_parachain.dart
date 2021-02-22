import 'package:flutter/material.dart';
import 'package:supernodeapp/configs/images.dart';
import 'parachain_card.dart';

class EntryParachainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60),
            Center(child: Image.asset(AppImages.datadash)),
            SizedBox(height: 35),
            Expanded(
              child: ParachainLoginCard(
                animation: AlwaysStoppedAnimation(1),
                fixed: true,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
