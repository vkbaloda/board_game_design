import 'package:flutter/material.dart';
import 'package:game_design/ui/game/pages/game_page.dart';
import 'package:game_design/ui/home/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.ROUTE_NAME,
      routes: {
        HomePage.ROUTE_NAME: (context) => HomePage(),
        GamePage.ROUTE_NAME: (context) => GamePage(),
      },
    );
  }
}
