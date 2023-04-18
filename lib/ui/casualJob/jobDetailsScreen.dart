import 'package:casual/models/casualJob/casualJob.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                  Constants.showFlutterToast("Applied Successfully!!", Colors.green);
                }, child: Text("Apply", style: Styles.headLineStyle4.copyWith(color: Colors.white),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
