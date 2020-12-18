import 'package:flutter/material.dart';

Widget miningTutorial() {
  return PageView(
    children: [_page1(), _page2(), _page3(), _page4()]);
}

Widget _page1 () {
  return Text('page1');
}

Widget _page2 () {
  return Text('page2');
}

Widget _page3 () {
  return Text('page3');
}

Widget _page4 () {
  return Text('page4');
}