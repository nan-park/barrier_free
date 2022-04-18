import 'package:flutter/material.dart';
import 'first_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Navigator',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
      },
    ),
  );
}
