import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Finder findByKey(String key) => find.byKey(Key(key));

Finder findByText(String text) => find.text(text);

bool isExisted(String key) => findByKey(key).precache();

Future<void> delay([int seconds = 1]) async {
  await Future<void>.delayed(Duration(seconds: seconds));
}

Future<void> idle(WidgetTester tester, {int seconds = 5}) async {
  for (int i = 0;i < seconds * 10000;i++) {
    await tester.idle();
  }
}

Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  bool timerDone = false;

  final timer = Timer(timeout, 
      () => throw TimeoutException("Pump until has timed out"));

  while(timerDone != true) {
    await tester.pump();

    final found = tester.any(finder);
    if (found) {
      timerDone = true;
    }
  }
  
  timer.cancel();
}


Future<void> pumpAndTap(
  WidgetTester tester,
  String key, {
    int tapCount: 1
  }
) async {
  final Finder finder = find.byKey(Key(key)).first;
  await tester.pumpAndSettle();

  if (tapCount > 1) {
    int count = 0;
    while(count < tapCount) {
      await tester.tap(finder);
      ++ count;
    }
  } else {
    await tester.tap(finder);
  }
  
  await tester.pumpAndSettle();
}

Future<void> pumpAndEnterText(
  WidgetTester tester,
  String key,
  String value, {
    int tapCount: 1
  }
) async {
  final Finder finder = find.byKey(Key(key));
  await tester.pumpAndSettle();
  
  await tester.enterText(finder,value);
  
  await tester.pumpAndSettle();
}