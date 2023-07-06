

import 'dart:convert';
import 'dart:io';

import 'package:casual/models/casual.dart';
import 'package:casual/models/city.dart';
import 'package:casual/services/casual_service.dart';
import 'package:casual/ui/auth/login_screen.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final List<City> _cities = <City>[];

  bool _isLoading = false;

  Map<String, dynamic> _errors = <String, dynamic>{};

  // =======TextEditingController==================
  final _signUpForm = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController thaiNationalId = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  bool _obscure = true;
  bool _cPassObscure = true;
  int? cityValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCities();
  }

  String get getDate{
    return DateFormat('yyyy-MM-dd').format(_selectedDate);
    // return DateFormat.yMMMd().format(_selectedDate);
    // return DateFormat.yM().format(_selectedDate);
    // return DateFormat('MM-dd-yyyy').format(_selectedDate);
    // return DateFormat('dd-MMM-yyyy').format(_selectedDate);
  }
  String get getTime{
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute
    );
    return DateFormat('hh:mm a').format(dateTime);
    // return DateFormat('HH:mm a').format(dateTime); // 24 hour Railway Format
  }

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
                  _firstName(),
                  const Gap(14),
                  _lastName(),
                  const Gap(14),
                  _email(),
                  const Gap(14),
                  _phoneNo(),
                  const Gap(14),
                  _city(),
                  _errors['cityId'] != null ? Text(_errors['cityId'], style: TextStyle(color: Colors.red),) : Text(''),
                  const Gap(14),
                  _password(),
                  const Gap(14),
                  _cpassword(),
                  const Gap(14),
                  Row(
                    children: [
                      ElevatedButton(onPressed: () => openDatePicker(), child: Text("DOB")),
                      Gap(20),
                      Text('Selected DOB : $getDate')
                    ],
                  ),
                  _errors['date_of_birth'] != null ? Text(_errors['date_of_birth'], style: TextStyle(color: Colors.red),) : Gap(5),
                  // Row(
                  //   children: [
                  //     ElevatedButton(onPressed: () => openTimePicker(), child: Text("Time")),
                  //     Gap(20),
                  //     Text("Selected Time - $getTime")
                  //   ],
                  // ),
                  const Gap(14),
                  _thaiID(),
                  _avatar != null ?
                  ClipOval(
                    child: Image.file(_avatar!, width: 150, height: 150, fit: BoxFit.cover),
                  ): Center(),
                  const Gap(10),
                  _buildButton(title: "profile", icon: Icons.camera_alt_outlined, onClicked: () async {
                    // pickImage(ImageSource.camera, "avatar");
                    openBottomSheet(context);
                  }),
                  Gap(10),
                  _errors['casual_avatar'] != null ?
                      Text(_errors['casual_avatar'], style: TextStyle(color: Colors.red),):
                      Text(""),
                  Divider(thickness: 1,color: Colors.blueGrey,),
                  _idProofFront != null ?
                  ClipOval(
                    child: Image.file(_idProofFront!, width: 150, height: 150, fit: BoxFit.cover,),
                  ):Center(),
                  const Gap(14),
                  _buildButton(title: "id Proof Front", icon: Icons.camera_alt_outlined, onClicked: () {
                    pickImage(ImageSource.camera, "idProofFront");
                  }),
                  _errors['id_card_front_photo'] != null ?
                  Text(_errors['id_card_front_photo'], style: TextStyle(color: Colors.red),):
                  Text(""),
                  Divider(thickness: 1,color: Colors.blueGrey,),
                  _idProofBack != null ?
                  ClipOval(
                    child: Image.file(_idProofBack!, width: 150, height: 150, fit: BoxFit.cover,),
                  ):Center(),
                  const Gap(14),
                  _buildButton(title: "Id Proof Back", icon: Icons.camera_alt_outlined, onClicked: () {
                    pickImage(ImageSource.camera, "idProofBack");
                  }),
                  _errors['id_card_back_photo'] != null ?
                  Text(_errors['id_card_back_photo'], style: TextStyle(color: Colors.red),):
                  Text(""),
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
  Widget _buildButton(
      {required String title,
        required IconData icon,
        required VoidCallback onClicked}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(46),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 15)),
      onPressed: onClicked,
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
          ),
          Gap(16),
          Text(title)
        ],
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

  void openBottomSheet(BuildContext context){
    showModalBottomSheet(context: context,
      isDismissible: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
        top: Radius.circular(25)
      )),
      builder: (context){
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(alignment: Alignment.topRight,
                child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera, "avatar");
                }, child: Row(
                  children: [Icon(Icons.camera_alt_outlined),Text("Camera")],
                )),
                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.gallery, "avatar");
                  }, child: Row(
                    children: [Icon(Icons.photo_album_outlined),Text("Gallery")],
                  ))
                ],
              ),
            ),
            Gap(20)
          ],
        ),
      );
    },);
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

  Widget _firstName(){
    return Container(
      height: 70,
      child: TextFormField(
        controller: firstName,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "First Name",
          hintText: "casual",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person)
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "First Name is required!";
          }
          if(_errors['casual_first_name'] != null){
            return _errors['casual_first_name'];
          }
          return null;
        },
      ),
    );
  }

  Widget _lastName(){
    return Container(
      height: 70,
      child: TextFormField(
        controller: lastName,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(),
          labelText: "Last Name",
          hintText: "raj",
          prefixIcon: Icon(Icons.person_outline)
        ),
      validator: (value) {
        if(value!.isEmpty){
          return "Last Name is required!!";
        }
        if(_errors['casual_last_name'] != null){
          return _errors['casual_last_name'];
        }
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
          if(_errors['email'] != null){
            return _errors['email'];
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
          if(_errors['casual_phone_no'] != null){
            return _errors['casual_phone_no'];
          }
          return null;
        },
      ),
    );
  }

  Widget _city(){
    return Container(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(),
        ),
        value: cityValue,
        hint: Text("select city"),
        icon: Icon(Icons.keyboard_arrow_down),
        items: _cities.map((city){
          return DropdownMenuItem(
              value: city.id,child: Text(city.city_name.toString()));
        }).toList(),
        isExpanded: true,
        onChanged: (value) {
          // print(value);
          setState(() {
            cityValue = value as int;
          });
        },
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item,child: Text(item, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),);

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
          if(_errors['password'] != null){
            return _errors['password'];
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
          if(_errors['passwordConfirmation'] != null){
            return _errors['passwordConfirmation'];
          }
          return null;
        },
      ),
    );
  }

  Widget _thaiID() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: thaiNationalId,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Thai ID",
          hintText: "enter 13 digit thai national id!",
          border: OutlineInputBorder()
        ),
        validator: (value) {
          if(value!.isEmpty){
            return "Thai ID is required!";
          }
          if(_errors['thaiNationalId'] != null){
            return _errors['thaiNationalId'];
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
        model.casual_first_name = firstName.text;
        model.casual_last_name = lastName.text;
        model.email = email.text;
        model.casual_phone_no = phoneNo.text;
        // model.cityId = int.tryParse(city.text);
        model.cityId = cityValue;
        model.password = password.text;
        model.passwordConfirmation = cPassword.text;
        model.date_of_birth = getDate;
        model.thaiNationalId = thaiNationalId.text;
        // print(model.cityId.runtimeType);
        setState(() {
          _isLoading = true;
        });
        _signUpForm.currentState!.validate();
        register(context, model);
      },child: _isLoading ? CircularProgressIndicator() :  Text("Register Now"),),
    );
  }

  register(BuildContext context, Casual model) async{
    try {
      var result = await _casualService.registerCasual(this.fileData, model);
      // print(result.stream.bytesToString());
      // final decodedMap = json.decode(result);
      // print(result.statusCode);
      setState(() {
        _isLoading = false;
        _errors = _casual.getCasualDataWithNull();
      });
      if(result['status']){
        Constants.showFlushBar(context, result['message']);
        Constants.goToLogin(context, LoginScreen());
      }else{
        if(result.containsKey('error')){
          // print(result['error']);
          result['error'].forEach((errors) {
            // print(errors);
            _errors.forEach((key, value) {
              if(errors['param'] == key && _errors[key] == null){
                _errors[key] = errors['msg'];
              }
            });
          });


          print(_errors);
        }
      }
      _signUpForm.currentState!.validate();

    } on Exception catch (e) {
      Constants.showFlushBar(context, e.toString());
    }
  }

  Future<List<City>?> fetchCities() async {
    // print(_cities);
     try {
       Map<String, dynamic> result = await _casualService.getCities();
       // print(result);
       if(result['status']){
         result['cities'].forEach((city) {
            // print(city);
            setState(() {
              _cities.add(City.fromJson(city));
            });
         });
       }
     } on Exception catch (e) {
       Constants.checkTokenExpiration(context, e);
     }
    // print(_cities[0]);
    return _cities;
  }

  Future<void> openDatePicker() async {
    final selectedDate = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(1960, 4, 1), lastDate: DateTime.now());

    if(selectedDate != null){
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  Future<void> openTimePicker() async {
    final selectedTime = await showTimePicker(context: context, initialTime: _selectedTime);

    if(selectedTime != null){
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }




}
