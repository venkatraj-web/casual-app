import 'dart:async';
import 'dart:convert';

import 'package:casual/models/casual.dart';
import 'package:casual/services/casual_service.dart';
import 'package:casual/ui/bottom_bar.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsecure = true;
  CasualService _casualService = CasualService();
  Casual _casual = Casual();
  Map<String, dynamic> _errors = new Map<String, dynamic>();

  // ===============TextEditingController ===================
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // ================Form Key===================
  final _loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Casual Login"),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _loginForm,
              child: Column(
                children: [
                  Gap(14),
                  _title(),
                  _email(),
                  Gap(10),
                  _password(),
                  Gap(24),
                  _loginButton(),
                  Gap(24),
                  _goToSignup()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      height: 90,
      child: Column(
        children: [
          Text("Welcome to", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text("Qikcasual", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

  Widget _email() {
    return Container(
      height: 70,
      child:
      TextFormField(
        controller: email,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: "Email",
            hintText: "example@gmail.com",
            border: OutlineInputBorder()
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
        validator: (value) {
          if(value!.isEmpty){
            return "please enter email address";
          }
          if(_errors['email'] != null){
            return _errors['email'];
          }
          return null;
        },
      ),
    );
  }
  
  Widget _password() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: password,
        obscureText: _obsecure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "password",
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(_obsecure ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obsecure = !_obsecure;
              });
            },
          )
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "please enter password";
          }
          if(_errors['password'] != null){
            return _errors['password'];
          }
          return null;
        },
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
          )
        ),
        onPressed: () {
          print("Logged In");
          var model = new Casual();
          model.email = email.text;
          model.password = password.text;
          _loginForm.currentState!.validate();
          _login(context, model);

        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text("Login as Casual", style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }

  Widget _goToSignup(){
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
          )
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("Register For a Job",
            style: TextStyle(fontSize: 18.0),),
        ),
        onPressed: () {

        },
      )
    );
  }

  _login(BuildContext context, Casual model) async{

    try {
      // print("Email : ${model.email}");
      // print("Password : ${model.password}");

      var result = await _casualService.getLogin(model);
      // print("Result = ");
      print(result);
      setState(() {
        _errors = _casual.getCasualDataWithNull();
      });
      // print(jsonDecode(result.body));
      if(result['status']){
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setString('token', result['token']);
        print(result['message']);
        Constants.showFlushBar(context, result['message']);
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => BottomBar()));
        });
      }else{
        if(result.containsKey('error')){
          result['error'].forEach((errors) {
            // print(errors);
            _errors.forEach((key,value) {
              // print("key = $key");
              if (errors['param'] == key && _errors[key] == null) {
                // print("Value = ${errors['msg']}");
                _errors[key] = errors['msg'];
              }
            });
          });
          print(_errors);
          Constants.showFlutterToast("All fields are mandatory!!", Colors.redAccent);
        }
        if(result.containsKey('message')) {
          print(result['message']);
          Constants.showFlushBar(context, result['message']);
        }
      }
      _loginForm.currentState!.validate();
    } on Exception catch (e) {
     // print(e);
      Constants.showFlushBar(context, e.toString());
     //  Constants.showFlutterToast(e.toString(),Colors.black);
    }

  }


}
