// ignore_for_file: sort_child_properties_last, file_names, unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';
import 'package:iptapp/controllers/report_controller.dart';
import 'package:iptapp/models/report.dart';
import 'package:iptapp/models/student.dart';
import 'package:iptapp/pages/registration_page.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
   var selectedIPT = "";
   TextEditingController titleController = TextEditingController();
   TextEditingController descriptionController = TextEditingController();
   bool uploading = false;
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: const Color.fromARGB(255, 116, 15, 15),
      title:const Text("New report",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
        body: Form(
         key: _formKey,
          child: Stack(
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
              backgroundColor: const Color.fromARGB(210, 0, 0, 0),
              drawer: const Drawer(),
             
              body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                  
                      
                      //  const Spacer(),
             const SizedBox(height:20),
        
               TextFormField(
           style: const TextStyle(color: Colors.white),
           controller: titleController,
            validator: (value){
             if(value!.isEmpty){
               return "Enter report title";
             }
             return null;
             
           },
           decoration: const InputDecoration(
           border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
           labelStyle: TextStyle(color: Colors.white60),
          
           labelText: "Report title"
           )),
          const SizedBox(height:10,),
             
             TextFormField(
           style: const TextStyle(color: Colors.white),
           maxLines: 15,
           minLines: 7,
           controller: descriptionController,
            validator: (value){
             if(value!.isEmpty){
               return "Enter report description";
             }
             return null;
             
           },
           decoration: const InputDecoration(
           border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
           // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
           enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
             
           labelStyle: TextStyle(color: Colors.white60),
           labelText: "Report description"
           )),
            
             
            
             const SizedBox(height:30),
          
            GestureDetector(
             onTap: () {
             
             if(_formKey.currentState!.validate()){
                  setState(() {
                    uploading = true;
                  });
                  AuthController().findUserInfo().then((Student student){
                  final title = titleController.text;
                  final description = descriptionController.text;
                  ReportController().addReport(Report(title, description, student.IPTId)).then((value) {
                     setState(() {
                    uploading = false;
                    Get.back();
                  });
                  });
                });
             }
             },
              child: ClipRRect(
               borderRadius: BorderRadius.circular(5),
                child:  Material(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 20),
                   child: Center(
                     child:  uploading? const CircularProgressIndicator(color: Colors.white,):  const Text("Add report",style: TextStyle(fontSize: 18,
                                 color: Colors.white,
                                fontWeight: FontWeight.bold),),
                   ),
                 ),
                color:Colors.green ),
              ),
            )
          ,
            
            
             const SizedBox(height: 20,),
          
            ],),
          ),
              ),
            ))
            ],
          ),
        ),
      );
    
    
    
     
  }
}