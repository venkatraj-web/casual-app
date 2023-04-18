import 'package:casual/models/property/property.dart';
import 'package:casual/services/property/casualPropertyService.dart';
import 'package:casual/ui/casualJob/jobListScreen.dart';
import 'package:casual/ui/common/helpScreen.dart';
import 'package:casual/utils/app_styles.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({Key? key}) : super(key: key);

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {

  CasualPropertyService _casualPropertyService = CasualPropertyService();
  List<Property> _propertyList = <Property>[];

  bool? _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProperties();
  }

  Future<List<Property>> getProperties() async{
    try {
      var result = await _casualPropertyService.getProperties();

      setState(() {
        _isLoading = false;
      });
      if(result != null){
        if(result['status']){
          result['properties'].forEach((data){
            setState(() {
              _propertyList.add(Property.fromJson(data));
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
    return _propertyList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Property", style: Styles.headLineStyle2.copyWith(color: Colors.white),)),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HelpScreen()));
            },
            itemBuilder: (context) => [
            PopupMenuItem(child: Row(
              children: [
                Icon(Icons.help_center, color: Styles.darkBgColor,),
                Gap(10),
                Text("Help")
              ],
            ), value: 1,)
          ],)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 15),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10, left: 15),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Properties", style: Styles.headLineStyle1.copyWith(color: Colors.white),),
                        Padding(padding: EdgeInsets.only(right: 8),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              Icon(Icons.room_preferences, color: Colors.white,),
                              Text("${_propertyList!.length} Properties", style: Styles.headLineStyle4.copyWith(color: Colors.white),)
                            ],
                          ),)
                      ],
                    ),
                    Gap(20),
                    _isLoading! ? CircularProgressIndicator(color: Colors.white,) : Expanded(child: buildPropertyList()),
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

  Widget buildPropertyList(){
    return Container(
      child: _propertyList.length > 0 ? ListView.separated(itemBuilder: (context, index) {
        final item = _propertyList[index];
        return buildPropertyCard(item);
      },physics: BouncingScrollPhysics(), separatorBuilder: (context, index) => Gap(20), itemCount: _propertyList.length)
          : Text("Properties Data not Found!!", style: Styles.headLineStyle1.copyWith(color: Colors.white),),
    );
  }

  Widget buildPropertyCard(Property item){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> JobListScreen(property: item,)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        height: 110,
        width: double.infinity,
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
                Text(item!.property_name!.toUpperCase(), style: Styles.headLineStyle3,),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  children: [
                  Icon(Icons.person_add),
                  Text("${item!.casual_jobs!.length} Vacancies", style: Styles.headLineStyle3,)
                ], )
              ],
            ),
            Gap(10),
            Text(item.client!.client_name!, style: Styles.headLineStyle4,),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 18,),
                    Text(item.city!.city_name!)
                  ],
                ),
                Text(item.propertyType!.property_type!, style: Styles.headLineStyle3,)
              ],
            )
          ],
        ),
      ),
    );
    
  }


}
