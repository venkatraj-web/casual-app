import 'package:casual/models/casualJob/casualJob.dart';
import 'package:casual/models/property/property.dart';
import 'package:casual/services/casualJob/casualJobService.dart';
import 'package:casual/services/property/casualPropertyService.dart';
import 'package:casual/ui/casualJob/jobDetailsScreen.dart';
import 'package:casual/ui/casualJob/jobListScreen.dart';
import 'package:casual/ui/property/propertyListScreen.dart';
import 'package:casual/utils/app_styles.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{

  List<Property> _propertyList = <Property>[];
  List<CasualJob> _casualJob = <CasualJob>[];
  CasualPropertyService _casualPropertyService = CasualPropertyService();
  CasualJobService _casualJobService = CasualJobService();

  bool? _isPropertyLoading = true;
  bool? _isCasualJobLoading = true;

  final df = new DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources(true);
  }

  Future<void> _loadResources(bool reload) async {
    _casualJob = [];
    _propertyList = [];
    await getJobs();
    await getProperties();
  }

  Future<List<CasualJob>> getJobs()  async {
    try {
      var result = await _casualJobService.getJobs();
      if(result != null){
        if(result['status']){
          // print(result);
          result['casual_jobs'].forEach((data){
            setState(() {
              _isCasualJobLoading = false;
              _casualJob.add(CasualJob.fromJson(data));
            });
          });
        }else{
          Constants.showSnackBar(context);
        }
      }else{
        Constants.showFlutterToast("No Data", Colors.yellowAccent);
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
    // print(_casualJob);
    return _casualJob;
  }

  Future<List<Property>> getProperties() async {
    try {
      var result = await _casualPropertyService.getProperties();
      // print(result["properties"][0]['casual_jobs'][1]);
      // print(result["properties"].length);
      if(result != null){
        if(result['status']){
          result['properties'].forEach((data){
            setState(() {
              // print(data);
              _isPropertyLoading = false;
              _propertyList.add(Property.fromJson(data));
            });
          });
        }else{
          Constants.showSnackBar(context);
        }
      }else{
        Constants.showFlutterToast("No Data", Colors.yellow);
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
    return _propertyList;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
         await _loadResources(true);
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  width: double.infinity,
                  height: Constants.screenSize(context).height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18)),
                    color: Color(0Xff111E28)
                  ),
                  child: Column(
                    children: [
                      Gap(18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Top Jobs".toUpperCase(),
                          style: TextStyle(color: Colors.white,wordSpacing: 4,letterSpacing: 1.5),),
                          GestureDetector(
                            onTap: () {
                              print("Load more");
                              Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyListScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: Text("Load More".toUpperCase(),
                                style: TextStyle(color: Colors.white,wordSpacing: 4,letterSpacing: 1.5),),
                            ),
                          )
                        ],
                      ),
                      Gap(18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _isPropertyLoading! ? CircularProgressIndicator(color: Colors.white,) : Expanded(child: buildPropertyList())
                        ],
                      ),
                      Gap(18),
                      Row(
                        children: [
                          Text("Suggest Jobs".toUpperCase(), style: TextStyle(
                            color: Colors.white, wordSpacing: 8, letterSpacing: 1.5
                          ),)
                        ],
                      ),
                      Gap(18),
                      _isCasualJobLoading! ? CircularProgressIndicator(color: Colors.white,) : Expanded(child: buildCasualJobList())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget buildPropertyList(){
    return Container(
      height: 200,
      child: _propertyList.length > 0 ? ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => Gap(20),
        itemCount: _propertyList.length,
        itemBuilder: (context, index) {
          final item = _propertyList[index];
          return propertyList(item);
        },
      ) : Text("No Property Data Founded!!", style: TextStyle(color: Colors.white),),
    );
  }

  Widget propertyList(Property item) {
    return Stack(
      // clipBehavior: Clip.hardEdge,
      children: [
        Container(
          // clipBehavior: Clip.hardEdge,
          width: Constants.screenSize(context).width * 0.5,
          height: Constants.screenSize(context).longestSide,
          padding: EdgeInsets.only(top: 15, left: 20, right: 10, bottom: 40),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item!.property_name!.toUpperCase(), style: Styles.headLineStyle1,),
                Gap(14),
                Text("${item!.casual_jobs!.length} Vacancies", style: Styles.headLineStyle2,),
                Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin),
                    Text(item!.city!.city_name!, style: Styles.headLineStyle3,)
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
          onTap: () {
            print("Show All");
            Navigator.push(context, MaterialPageRoute(builder: (_)=> JobListScreen(property: item,)));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            width: 130,
            height: 40,
            decoration: BoxDecoration(
              color: Styles.secondaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomRight: Radius.circular(20))
            ),
            child: Center(child: Text("Show All", style: Styles.headLineStyle2,)),
          ),
        ))
      ],
    );
  }

  Widget buildCasualJobList(){
    return Container(
      child:_casualJob.length > 0 ? ListView.separated(itemBuilder: (context, index) {
        final job = _casualJob[index];
        return CasualJobCard(job);
      }, separatorBuilder: (context, index) => Gap(10), itemCount: _casualJob.length,
      physics: BouncingScrollPhysics(),)
          : Text("No Casual Job Data Founded!!", style: TextStyle(color: Colors.white),) ,
    );
  }

  Widget CasualJobCard(CasualJob job){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetailsScreen(job: job,)));
      },
      child: Container(
        width: double.infinity,
        height: 110,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(job.job_title!.toUpperCase(), style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 15
                ),),
                Text("${job.amount} BAHT/day".toUpperCase(), style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 15
                ),),
              ],
            ),
            Gap(10),
            Text(job.property!.property_name!,
              style: TextStyle(color: Color(0xffE47B01), fontSize: 16),),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, size: 18,),
                    Text(job.city!.city_name!, style: TextStyle(fontWeight: FontWeight.bold,
                    letterSpacing: 1, fontSize: 12, color: Color(0xff4C646A)),)
                  ],
                ),
                Text("Casual".toUpperCase(), style: TextStyle(
                   fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 12, color: Color(0xff4C646A)
                ),),
                Text(job!.start_date!, style: TextStyle(
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
