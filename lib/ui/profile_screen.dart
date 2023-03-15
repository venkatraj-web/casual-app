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

class _ProfileScreenState extends State<ProfileScreen> {
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
      child: _isLoading 
          ? Center(child: CircularProgressIndicator(),)
      : ListView(
        children: [
          Column(
            children: [
              Gap(14),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: _casual!.casualAvatar == null
                    ? Image.asset("assets/images/person.png").image
                    : NetworkImage(Constants.S3Bucket + _casual!.casualAvatar!),
                  radius: 70,
                ),
              ),
              Gap(14),
              Text("Name : ${_casual!.casualName}"),
              Gap(14),
              Text("Email : ${_casual!.email}"),
              Gap(14),
              Text("PhoneNo : ${_casual!.casualPhoneNo}"),
              Gap(14),
              Text("City : ${_casual!.city!.cityName}"),
              Gap(14),

            ],
          )
        ],
      )
    );
  }
}
