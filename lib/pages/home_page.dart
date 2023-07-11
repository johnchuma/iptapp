// ignore_for_file: sort_child_properties_last, avoid_print, unused_import

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';
import 'package:iptapp/controllers/check_controller.dart';
import 'package:iptapp/controllers/place_controller.dart';
import 'package:iptapp/models/iptplace.dart';
import 'package:iptapp/models/student.dart';

import 'package:iptapp/pages/attendence_page.dart';
import 'package:iptapp/pages/edit_location.dart';
import 'package:iptapp/pages/reports_page.dart';
import 'package:iptapp/utils/colors.dart';
import 'package:jiffy/jiffy.dart';

import '../models/Check.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  bool isCheckedIn = false;
  bool allChecked = false;
  IPTplaces? iptplace;
  @override
  void initState() {

  CheckController().checkIfTodayCheckInExists().then((value) => isCheckedIn = value);
  CheckController().checkIfTodayCheckOutExists().then((value) => allChecked = value);

  Geolocator.requestPermission();

  final LocationSettings locationSettings = const LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position? position) {
        print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    
    return 
    Scaffold(
        body: Stack(
          children: [
            SizedBox(
             height: double.infinity,
              width: double.infinity,
              child:CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "https://www.afdb.org/sites/default/files/styles/1700x900/public/a1-students-youth.jpg?itok=Ir1r-poW"),),
          
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Scaffold(
      backgroundColor: AppColor.backgroundColor,
      drawer:  Drawer(backgroundColor: const Color.fromARGB(202, 0, 0, 0),child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
         [
          const SizedBox(height: 50,),
          const Text("DIT IPT app",style: TextStyle(fontWeight: FontWeight.w800,color:Color.fromARGB(255, 253, 255, 253), fontSize: 20),),
          const SizedBox(height: 20,),

          const Text("The DIT IPT App is designed to track daily attendance and assist you in recording daily reports. With this app, you can easily mark your attendance and submit daily reports, which will be directly accessible to your supervisor. Stay organized and streamline your reporting process with the DIT IPT App.",style: TextStyle(fontWeight: FontWeight.w400,color:Color.fromARGB(255, 167, 167, 167), fontSize: 14),),
          const SizedBox(height: 40,),
          GestureDetector(
          onTap: ()async{
            Student user = await AuthController().findUserInfo();
            Get.to(()=>EditLocation(user));
          },
          child: 
          ClipRRect(
                borderRadius: BorderRadius.circular(5),
                 child:  const Material(
                 
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child:Text( "Change IPT company",style: TextStyle(fontSize: 14,
                                  color: Colors.white,
                                 fontWeight: FontWeight.bold),),
                    ),
                  ),
                 color: Colors.green),
               ),
        ),
        const Spacer(),
       
        GestureDetector(
          onTap: (){
            AuthController().logout();
          },
          child: 
          ClipRRect(
                borderRadius: BorderRadius.circular(5),
                 child:  const Material(
                 
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child:Text( "Logout",style: TextStyle(fontSize: 14,
                                  color: Colors.white,
                                 fontWeight: FontWeight.bold),),
                    ),
                  ),
                 color:Color.fromARGB(255, 113, 12, 12) ),
               ),
        ),
        const SizedBox(height: 10,),

          
        ],),
      ),),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 116, 15, 15),
      actions: [GestureDetector(
        onTap: (){
            setState(() {
              
            });
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.refresh),
        ))],
      title:const Text("IPT dashboard",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
      body: FutureBuilder(
        future: AuthController().findPlaceInfo(),
        builder: (context,snapshot) {
          if(ConnectionState.waiting == snapshot.connectionState){
             return Center(child: const CircularProgressIndicator(color: Colors.white,));
          }
          iptplace = snapshot.data;
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  const SizedBox(height: 40,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children:  [
                        const Text("Today:",style: TextStyle(fontSize: 18),),
                        Text(Jiffy.parse(DateTime.now().toString()).format(pattern: "dd MMM yyyy"),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         ],),
                         Row(children:  [
                        const Text("IPT place:",style: TextStyle(fontSize: 18),),
                        Text(" ${iptplace?.name}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                       
                            
                         ],),
                        
                             Row(children:  [
                        const Text("Check in status: ",style: TextStyle(fontSize: 15),),
                        Text( isCheckedIn? "Checked in":"Not yet",style: TextStyle(fontSize: 15,color:isCheckedIn? Colors.green:Colors.black, fontWeight: FontWeight.bold),),
                         ],),
                       Row(children:  [
                        const Text("Check out status: ",style: TextStyle(fontSize: 15),),
                        Text(allChecked?"Checked out": "Not yet",style: TextStyle(fontSize: 15,color:allChecked? Colors.green:Colors.black,fontWeight: FontWeight.bold),),
                         ],),
                     
                      ],),
                    ),
                    color: AppColor.lightColor,),
                  ),
                  const SizedBox(height: 20,),
                 Row(
                   children: [
                     Expanded(
                       child: GestureDetector(
                        onTap: (){
                          Get.to(()=>const AttendencePage());
                        },
                         child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                           child: Container(
                                
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                Icon(Icons.calendar_month,size: 50,color: Color.fromARGB(255, 33, 9, 44),),
                                SizedBox(height: 20,),
                                 Text("Attendance report",style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                 color: Color.fromARGB(255, 33, 9, 44),)),
                              ],),
                            ),color: const Color.fromARGB(255, 215, 182, 255),),
                         ),
                       ),
                     ),
                     const SizedBox(width: 10,),
                      Expanded(
                       child: GestureDetector(
                        onTap: (){
                          Get.to(()=>const ReportPage());

                        },
                         child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                           child: Container(
                                
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Icon(Icons.note_add,size: 50,color: Color.fromARGB(255, 33, 9, 44),),
                                SizedBox(height: 20,),
                                 Text("Daily IPT report",style: TextStyle(fontSize: 15,
                                  color: Color.fromARGB(255, 57, 50, 9),
                                 fontWeight: FontWeight.bold),),
                              ],),
                            ),color: const Color.fromARGB(255, 255, 236, 166),),
                         ),
                       ),
                     ),
                   ],
                 ),
                 const Spacer(),
                if (allChecked) ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                     child:  const Material(
                     
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child:Text( "Have a nice rest",style: TextStyle(fontSize: 18,
                                      color: Colors.white,
                                     fontWeight: FontWeight.bold),),
                        ),
                      ),
                     color:Color.fromARGB(255, 3, 24, 4) ),
                   ) else GestureDetector(
                  onTap: ()async{
                    setState(() {
                      loading = true;
                    });
                  var iptPlace = await AuthController().findPlaceInfo(); 
                  Position? userLocation = await AuthController().getUserLocation();
                  if(userLocation != null){
                        bool isAround = AuthController().checkIfUserIsAround(userLocation, iptPlace);
                        if(isAround){
                          bool checkedIn = await CheckController().checkIfTodayCheckInExists();
                          if(checkedIn){
                            await CheckController().checkout();
                            isCheckedIn = await  CheckController().checkIfTodayCheckInExists();
                            allChecked = await CheckController().checkIfTodayCheckOutExists();
                            setState(() {
                              loading = false;
                            });
                          }
                          else{
                            await CheckController().checkin(Check(iptPlace.id));
                            isCheckedIn = await  CheckController().checkIfTodayCheckInExists();
                            allChecked = await CheckController().checkIfTodayCheckOutExists();
                              setState(() {
                              loading = false;
                            });
                          }
                        }
                        else{
                          var distance = AuthController().distanceFromOrganization(userLocation, iptPlace);
                          Get.snackbar("Out of parameter", "You are ${(distance/1000).round()}Km from ${iptPlace.name}, you can not checkin",backgroundColor: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: const EdgeInsets.all(20),padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20));
                        await Geolocator.requestPermission();
                      setState(() {
                      loading = false;
                    });
                        }
                  }else {
                   
                    await Geolocator.requestPermission();
                      setState(() {
                      loading = false;
                    });
                  }
                  
                  },
                   child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                     child:  Material(
                     
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child:loading ?const CircularProgressIndicator(color: Colors.white,):   Text( isCheckedIn? "Check out":"Check in",style: const TextStyle(fontSize: 18,
                                      color: Colors.white,
                                     fontWeight: FontWeight.bold),),
                        ),
                      ),
                     color:Colors.green ),
                   ),
                 )
                ],),

              ),
            ],
          );
        }
      ),
    ) )
          ],
        ),
      );
    
    
    
    
  }
}