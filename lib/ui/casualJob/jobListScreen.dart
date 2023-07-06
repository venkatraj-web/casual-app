import 'package:casual/models/casualJob/casualJob.dart';
import 'package:casual/models/property/property.dart';
import 'package:casual/services/casualJob/casualJobService.dart';
import 'package:casual/ui/casualJob/jobDetailsScreen.dart';
import 'package:casual/ui/common/helpScreen.dart';
import 'package:casual/ui/home_screen.dart';
import 'package:casual/utils/app_styles.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobListScreen extends StatefulWidget {
  Property? property;
  JobListScreen({this.property, Key? key}) : super(key: key);

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {

  CasualJobService _casualJobService = CasualJobService();
  List<CasualJob> _casualJob = <CasualJob>[];

  bool? _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCasualJobsByPropertyId();
  }

  Future<List<CasualJob>> getCasualJobsByPropertyId() async {
    try {
      var result = await _casualJobService.getCasualJobsByPropertyId(this.widget.property!.id);
      print(result);

      setState(() {
        _isLoading = false;
      });
      if(result != null){
        if(result['status']){
          result['casual_jobs'].forEach((data) {
            setState(() {
              _casualJob.add(CasualJob.fromJson(data));
            });
          });
        }
      }else{
        Constants.showSnackBar(context);
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
    return _casualJob;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(this.widget.property!.property_name!, style: Styles.headLineStyle2.copyWith(color: Colors.white),)),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HelpScreen()));
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.help, color: Styles.darkBgColor,),
                    Gap(10),
                    Text("Help")
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                height: Constants.screenSize(context).height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Styles.darkBgColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18))
                ),
                child: Column(
                  children: [
                    Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.location_on, size: 18,color: Styles.errorColor),
                        Text(widget.property!.city!.city_name!,  style: TextStyle(fontWeight: FontWeight.bold,
                            letterSpacing: 1, fontSize: 12, color: Styles.lightBgColor))
                      ],
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Jobs", style: Styles.headLineStyle1.copyWith(color: Colors.white),),
                        Padding(padding: EdgeInsets.only(right: 8),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: [
                            Icon(Icons.person_add, color: Colors.white,),
                            Text("${this.widget.property!.casual_jobs!.length!} Vacancies", style: Styles.headLineStyle4.copyWith(color: Colors.white),)
                          ],
                        ),)
                      ],
                    ),
                    Gap(20),
                    _isLoading! ? CircularProgressIndicator(color: Colors.white,) : Expanded(child: buildCasualJobList()),
                    Gap(20),
                  ],
                )
              ),
            ],
          ),
        )
      ),
    );
  }
  
  Widget buildCasualJobList(){
    return Container(
      child: _casualJob.length > 0 ? ListView.separated(itemBuilder: (context, index) {
        final job = _casualJob[index];
        return buildCasualJobCard(job);
      },
          physics:BouncingScrollPhysics(),separatorBuilder: (context, index) => Gap(20), itemCount: _casualJob.length)
          : Text("CasualJob Data Not Founded!!", style: Styles.headLineStyle1.copyWith(color: Colors.white),),
    );
  }
  
  Widget buildCasualJobCard(CasualJob job) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetailsScreen(job: job)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(job.job_title!.toUpperCase(), style: Styles.headLineStyle3,),
                Text("${job.amount} Bhat/day", style: Styles.headLineStyle3,)
              ],
            ),
            Gap(10),
            Text(job.client!.client_name!, style: Styles.headLineStyle4.copyWith(color: Colors.orange),),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Icon(Icons.location_on, size: 18,),
                //     Text(job.city!.city_name!,  style: TextStyle(fontWeight: FontWeight.bold,
                //         letterSpacing: 1, fontSize: 12, color: Color(0xff4C646A)))
                //   ],
                // ),
                Text("${job.no_of_casuals} Vacancies"),
                Text("Casual".toUpperCase(), style: TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 12, color: Color(0xff4C646A)
                ),),
                Text(job.start_date!, style: TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 14, color: Color(0xff4C646A)
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
  
}
