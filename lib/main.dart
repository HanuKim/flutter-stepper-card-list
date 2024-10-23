import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_test/pages/card/card.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '카드 관리 앱',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: CardListScreen(),
    );
  }
}
