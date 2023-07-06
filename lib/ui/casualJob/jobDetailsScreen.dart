import 'package:casual/models/casualJob/casualJob.dart';
import 'package:casual/services/casualJob/casualJobService.dart';
import 'package:casual/ui/auth/login_screen.dart';
import 'package:casual/utils/app_styles.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobDetailsScreen extends StatefulWidget {
  CasualJob? job;
  JobDetailsScreen({required this.job, Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  CasualJobService _casualJobService = CasualJobService();
  bool? isApplied = false;
  bool? isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkJobIsAppliedOrNot();
  }

  Future checkJobIsAppliedOrNot() async {
    try {
      var result = await _casualJobService.checkJobIsApplyiedOrNot(widget.job!.id);
      print(result);
      if(result['status']){
        setState(() {
          isApplied = true;
          isLoggedIn = true;
        });
      }else{
        if(result['message'] != "Your Token has Expired!. Please Log in again!"){
          setState(() {
            isLoggedIn = true;
          });
        }
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Details Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name : ${widget.job!.job_title}"),
            Gap(10),
            Text("City : ${widget.job!.city!.city_name}"),
            Gap(10),
            Text("Job Description : ${widget.job!.job_description}"),
            Gap(10),
            Text("Amount : ${widget.job!.amount} Bhat/day"),
            Gap(10),
            Text("Message for Casual : ${widget.job!.message_for_casual}"),
            Gap(10),
            Text("Outlet : ${widget.job!.outlet_name}"),
            Gap(10),
            Text("Reporting Person : ${widget.job!.reporting_person}"),
            Gap(10),
            Text("Start Date : ${widget.job!.start_date}"),
            Gap(10),
            Text("End Date : ${widget.job!.end_date}"),
            Gap(10),
            Text("Shift Time Start : ${widget.job!.shift_time_start}"),
            Gap(10),
            Text("Shift Time End : ${widget.job!.shift_time_end}"),
            Gap(15),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 80,
        color: Styles.darkBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You Will be Payed".toUpperCase(), style: Styles.headLineStyle4.copyWith(color: Styles.lightBgColor),),
                Gap(10),
                Text("${widget.job!.amount!} Bhat/day", style: Styles.headLineStyle3.copyWith(color: Styles.lightBgColor),)
              ],
            ),
            isLoggedIn! ? ElevatedButton(onPressed: () {
              isLoggedIn! ? jobApply(widget.job!.id) : Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
            },
              child: isLoggedIn! ? Container(
                child: isApplied! ? Text("Applied", style: Styles.headLineStyle4.copyWith(color: Colors.white),)
                    : Text("APPLY", style: Styles.headLineStyle4.copyWith(color: Colors.white),),
              ) : Text("LogIn to Apply"),
              style: ElevatedButton.styleFrom(
                  backgroundColor:isLoggedIn! ? isApplied! ? Styles.successColor : Styles.secondaryColor : Styles.errorColor
              ),
            ) : CircularProgressIndicator(color: Styles.lightBgColor,),
          ],
        ),
      ),
    );
  }

  jobApply(int? casualId) async {
    try {
      var result = await _casualJobService.jobApply(casualId);
      print(result);
      if(result['status']){
        Constants.showFlutterToast(result['message'], Colors.green);
        setState(() {
          checkJobIsAppliedOrNot();
        });
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
  }
}
