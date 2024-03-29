
import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:casual/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants{
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size; 
  }

  static const String LocalDomain = "http://192.168.1.7:3006/api";
  static const String Domain = "http://www.qikcasual.com/api";
  static const String S3Bucket = "https://qikcasual-dev-s3-upload.s3.ap-southeast-1.amazonaws.com/";
  static const Color PRIMARYBLUE = Color(0xff2C9FF5);
  static const Color SECONDARYBLUE = Color(0xff629AC4);

  static const Color primaryBlack = Color(0xff12344C);
  static const Color primarygrey = Color(0xff57595B);
  
  static showSnackBar(BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error", style: TextStyle(color: Colors.white, fontSize: 20),))
    );
  }
  
  static showFlutterToast(msg, Color color){
    if(msg == null){
      return ;
    }
    return Fluttertoast.showToast(msg: msg, backgroundColor: color,fontSize: 15, gravity: ToastGravity.BOTTOM);
  }
  
  static showFlushBar(BuildContext context, String msg){
    return Flushbar(
      message: msg,
      backgroundGradient: LinearGradient(colors: [
        Colors.black,Colors.red
      ]),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      borderRadius: BorderRadius.circular(15),
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error, color: Colors.white),
    ).show(context);
  }

  static goToLogin(BuildContext context, Widget materialPageRoute){
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(ctx) => materialPageRoute), (route) => false);
    });
  }

  static checkTokenExpiration(BuildContext context, e){
    // if(e.toString() == "Unauthenticated."){
    if(e.toString() == "Your Token has Expired!. Please Log in again!"){
      // showFlushBar(context, "Unauthorised : ${e}");
      showFlushBar(context, e.toString());
      Timer(Duration(seconds: 2), () async {
        SharedPreferences _pref = await SharedPreferences.getInstance();
        // print(_pref.get('token'));
        _pref.remove('token');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => LoginScreen()),
              (route) => false,
        );
      });
    }else{
      showFlushBar(context, e.toString());
    }
  }

  static showLogoutDialog(BuildContext context){
    showDialog(context: context, barrierDismissible: false,
    builder: (context){
      return AlertDialog(
        title: Text("Are you sure!"),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("Cancel")),
          ElevatedButton(onPressed: () async {
            SharedPreferences _prefs = await SharedPreferences.getInstance();
            _prefs.remove('token');
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => LoginScreen()), (route) => false);
          }, child: Text("Logout"))
        ],
      );
    });
  }



  
}