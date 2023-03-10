import 'dart:async';

import 'package:casual/ui/auth/login_screen.dart';
import 'package:casual/ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _token;

  @override
  void initState(){
    _checkAuth();
    super.initState();
  }
  
  Future<void> _checkAuth() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _token = _pref.getString('token');
    print("token = ${_token}");
    Timer(Duration(seconds: 2), () {
      // print("Check Auth");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return (_token != null) ? BottomBar() : LoginScreen();
      }));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Casual"),
        ),
      ),
      body: Center(child: CircularProgressIndicator(
        color: Colors.black,
      )),
    );
  }
}
