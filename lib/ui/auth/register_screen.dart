

import 'dart:convert';
import 'dart:io';

import 'package:casual/models/casual.dart';
import 'package:casual/services/casual_service.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _avatar, _idProofFront, _idProofBack;
  List<File> images = [];
  List fileData = [];
  final CasualService _casualService = CasualService();
  final Casual _casual = Casual();

  // =======TextEditingController==================
  final _signUpForm = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  bool _obscure = true;
  bool _cPassObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Casual Register"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _signUpForm,
              child: Column(
                children: [
                  const Gap(14),
                  _title(),
                  const Gap(14),
                  _name(),
                  const Gap(14),
                  _email(),
                  const Gap(14),
                  _phoneNo(),
                  const Gap(14),
                  _city(),
                  const Gap(14),
                  _password(),
                  const Gap(14),
                  _cpassword(),
                  const Gap(14),
                  _avatar != null ?
                  ClipOval(
                    child: Image.file(_avatar!, width: 150, height: 150, fit: BoxFit.cover),
                  ): Center(),
                  const Gap(14),
                  ElevatedButton(onPressed: () async {
                    pickImage(ImageSource.camera, "avatar");
                  }, child: Text("profile")),
                  Divider(thickness: 1,color: Colors.blueGrey,),
                  _idProofFront != null ?
                  ClipOval(
                    child: Image.file(_idProofFront!, width: 150, height: 150, fit: BoxFit.cover,),
                  ):Center(),
                  const Gap(14),
                  ElevatedButton(onPressed: () {
                    pickImage(ImageSource.camera, "idProofFront");
                  }, child: Text("Id Proof Front")),
                  Divider(thickness: 1,color: Colors.blueGrey,),
                  _idProofBack != null ?
                  ClipOval(
                    child: Image.file(_idProofBack!, width: 150, height: 150, fit: BoxFit.cover,),
                  ):Center(),
                  const Gap(14),
                  ElevatedButton(onPressed: () {
                    pickImage(ImageSource.camera, "idProofBack");
                  }, child: Text("Id Proof Back")),
                  Divider(thickness: 1,color: Colors.blueGrey,),
                  _registerButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _title(){
    return Container(
      height: 90,
      width: double.infinity,
      child: Column(
        children: const [
          Text(
            "Register for Job",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Gap(10),
          Text(
            "Enter Contact Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  pickImage(ImageSource source, String fileName) async{
    final img = await ImagePicker().pickImage(source: source);
    if(img == null) return;
    final imgTemporary = File(img!.path);
    setState(() {
      if(fileName == 'avatar'){
        this._avatar = imgTemporary;
        // images.add(this._avatar!);
        fileData.add({"name": "casual_avatar", "file" : this._avatar});
      }else if(fileName == 'idProofFront'){
        this._idProofFront = imgTemporary;
        // images.add(this._idProofFront!);
        fileData.add({"name": "id_card_front_photo", "file" : this._idProofFront});
      }else if(fileName == 'idProofBack'){
        this._idProofBack = imgTemporary;
        // images.add(this._idProofBack!);
        fileData.add({"name": "id_card_back_photo", "file" : this._idProofBack});
      }
    });
  }

  Widget _name(){
    return Container(
      height: 70,
      child: TextFormField(
        controller: name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Name",
          hintText: "casual",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "Name is required!";
          }
          return null;
        },
      ),
    );
  }

  Widget _email(){
    return Container(
      height: 70,
      child: TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: "Email",
            hintText: "example@gmail.com",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email_outlined)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "Email is required!";
          }
          return null;
        },
      ),
    );
  }

  Widget _phoneNo(){
    return Container(
      height: 70,
      child: TextFormField(
        controller: phoneNo,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: "Phone No",
            hintText: "12345678",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone_android)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "Phone No is required!";
          }
          return null;
        },
      ),
    );
  }

  Widget _city(){
    return Container(
      child: TextFormField(
        controller: city,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "City",
          prefixIcon: Icon(Icons.location_city),
          border: OutlineInputBorder()
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "City is required";
          }
          return null;
        },
      ),
    );
  }

  Widget _password(){
    return Container(
      height: 70,
      child: TextFormField(
        controller: password,
        obscureText: _obscure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: "Password",
            suffixIcon: IconButton(onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            }, icon: _obscure ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
            border: OutlineInputBorder(),
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "Password is required!";
          }
          return null;
        },
      ),
    );
  }

  Widget _cpassword(){
    return Container(
      height: 70,
      child: TextFormField(
        controller: cPassword,
        obscureText: _cPassObscure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: "Confirm Password",
            suffixIcon: IconButton(onPressed: () {
              setState(() {
                _cPassObscure = !_cPassObscure;
              });
            }, icon: _cPassObscure ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
            border: OutlineInputBorder(),
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "Confirm Password is required!";
          }
          return null;
        },
      ),
    );
  }

  Widget _registerButton(){
   return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),onPressed: () {
        var model = new Casual();
        model.casualName = name.text;
        model.email = email.text;
        model.casualPhoneNo = phoneNo.text;
        model.cityId = int.tryParse(city.text);
        model.password = password.text;
        model.passwordConfirmation = cPassword.text;
        print(model.cityId.runtimeType);
        _signUpForm.currentState!.validate();
        register(context, model);
      },child: Text("Register Now"),),
    );
  }

  register(BuildContext context, Casual model) async{
    try {
      var result = await _casualService.registerCasual(this.fileData, model);
      // print(result.stream.bytesToString());
      // final decodedMap = json.decode(result);
      // print(result.statusCode);
      print(result);

    } on Exception catch (e) {
      Constants.showFlushBar(context, e.toString());
    }
  }




}
