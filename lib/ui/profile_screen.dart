import 'package:casual/models/casual.dart';
import 'package:casual/services/casual_service.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  CasualService _casualService = CasualService();
  Casual? _casual;
  Map<String, dynamic> _casualData = new Map<String, dynamic>();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getCasualProfile();
    super.initState();
  }

   getCasualProfile() async{
    try {
      var result = await _casualService.getCasualProfile();
      // print(result);
      if(result['status']){
        setState(() {
          _casualData = result['casual'];
          _casual = Casual.fromJson(result['casual']);
          _isLoading = false;
        });
        // print(Casual.fromJson(result['casual']).casualPhoneNo);
        // print(result['casual']);
      }else{
        // Constants.showSnackBar(context);
        Constants.checkTokenExpiration(context, result['message']);
      }
    } on Exception catch (e) {
      // Constants.showFlushBar(context, e.toString());
      // print( e);
      Constants.checkTokenExpiration(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: _isLoading 
          ? Center(child: CircularProgressIndicator(),)
      : ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(14),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: _casual!.casual_avatar == null
                    ? Image.asset("assets/images/person.png").image
                    : NetworkImage(Constants.S3Bucket + _casual!.casual_avatar!),
                  radius: 70,
                ),
              ),
              Gap(14),
              Text("Bio", style: TextStyle(fontSize: 25),),
              Gap(14),
              _txtBox("ID : ${_casual!.casual_id}"),
              Gap(14),
              _txtBox("Name : ${_casual!.casual_first_name}"),
              Gap(14),
              _txtBox("Email : ${_casual!.email}"),
              Gap(14),
              _txtBox("PhoneNo : ${_casual!.casual_phone_no}"),
              Gap(14),
              _txtBox("City : ${_casual!.city!.city_name}"),
              Gap(14),
            ],
          )
        ],
      )
    );
  }

  Widget _txtBox(String data){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(data),
    );
  }
}
