import 'package:casual/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Casual',
      theme:  ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: SplashScreen(),
    );
  }
}
