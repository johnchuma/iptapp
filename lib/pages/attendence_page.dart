// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/check_controller.dart';
import 'package:iptapp/utils/colors.dart';
import 'package:jiffy/jiffy.dart';

class AttendencePage extends StatelessWidget {
  const AttendencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
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
     
       appBar: AppBar(backgroundColor: const Color.fromARGB(255, 116, 15, 15),
      title:const Text("Attendance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
      body: GetX<CheckController>(
        init: CheckController(),
        builder: (find) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
            
               const SizedBox(height: 20,),
               Expanded(
                 child: ListView(children: find.checks.map((item) {
                  return  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color:  AppColor.lightColor,
                      child: ListTile(
                        tileColor: AppColor.lightColor,
                        
                        contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        
                        title:  Text(Jiffy.parse(item.checkin.toDate().toString()).format(pattern: "dd MMM yyyy"),style: const TextStyle(fontWeight: FontWeight.bold),),subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            const SizedBox(height: 5,),
                            Text("Check in time:${item.checkin.toDate().hour.toString().padLeft(2,'0')}:${item.checkin.toDate().minute.toString().padLeft(2,'0')}"),
                            Text("Check out time:${item.checkin.toDate().hour.toString().padLeft(2,'0')}:${item.checkin.toDate().minute.toString().padLeft(2,'0')}"),
                    
                          ],
                        ),),
                    ),
                  );
                 }) .toList()
                 
                 
                 ,),
               ),

                   
                ],),
              ),
            ),
          );
        }
      ),
    ))
          ],
        ),
      );
    
    
    
     
  }
}