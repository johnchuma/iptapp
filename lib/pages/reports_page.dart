// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/report_controller.dart';
import 'package:iptapp/pages/add_reports.dart';
import 'package:iptapp/pages/edit_report.dart';
import 'package:iptapp/utils/colors.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

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
    
       appBar: AppBar(backgroundColor: Color.fromARGB(255, 116, 15, 15),
      title:const Text("Daily reports",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
      body: GetX<ReportController>(
        init: ReportController(),
        builder: (find) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height-100,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 
            
               const SizedBox(height: 20,),
               Expanded(
                 child: ListView(children: find.reports.map((report) => Padding(
                   padding: const EdgeInsets.only(bottom: 10),
                   child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                     child: ListTile(
                      onTap: (){
                        Get.to(()=>EditReport(report));
                      },
                        tileColor: AppColor.lightColor,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      
                        title: Text(report.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),),
                      
                        subtitle: Text(report.description),),
                   ),
                 ) ).toList(),),
               ),

                     GestureDetector(
                  onTap: () {
                    Get.to(()=>const AddReport());
                  },
                   child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                     child: const Material(   
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text("Add new",style: TextStyle(fontSize: 18,
                                      color: Colors.white,
                                     fontWeight: FontWeight.bold),),
                        ),
                      ),
                     color:Colors.green ),
                   ),
                 )
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