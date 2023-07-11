// ignore_for_file: sort_child_properties_last, file_names, unused_import, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';
import 'package:iptapp/controllers/place_controller.dart';
import 'package:iptapp/controllers/report_controller.dart';
import 'package:iptapp/models/report.dart';
import 'package:iptapp/models/student.dart';
import 'package:iptapp/pages/registration_page.dart';
import 'package:iptapp/utils/colors.dart';

class EditLocation extends StatefulWidget {
  Student student;
   EditLocation(this.student,{super.key});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {

   var selectedIPT = "none";
   var selectedIPTname = "";

   bool uploading = false;
   final _formKey = GlobalKey<FormState>();
   @override
  void initState() {
    // selectedIPT = widget.student.IPTId;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: const Color.fromARGB(255, 116, 15, 15),
      title:const Text("Edit IPT organisation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
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
              backgroundColor: AppColor.backgroundColor,
              drawer: const Drawer(),
             
              body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             const SizedBox(height:20),
         GetX<PlaceController>(
            init: PlaceController(),
            builder: (find) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(height: 40,),
                // const SizedBox(height: 20,),
               
                        
                        //  const Spacer(),
               const SizedBox(height:30),
        
           DropdownButtonFormField<String>(
  value: selectedIPT,
  onChanged: (newValue) {
    setState(() {
    widget.student.IPTId = newValue!;
    });
  },
  decoration: const InputDecoration(
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
    labelStyle: TextStyle(color: Colors.white60),
    labelText: "IPT Company/organisation name",
  ),
  style: const TextStyle(color: Colors.grey),
  items: [
    const DropdownMenuItem<String>(
      value: "none", // Use a unique value instead of an empty string
      child: Text(
        "Select IPT organisation/company",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    ...find.places.map(
      (place) => DropdownMenuItem<String>(
        value: place.id,
        child: Text(
          place.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ],
),

             
             
              ],);
            }
          ),
        
             
            
             const SizedBox(height:30),
          
            GestureDetector(
             onTap: () async{
             
             if(_formKey.currentState!.validate()){
                  setState(() {
                    uploading = true;
                  });
                  AuthController().updateLocation(widget.student);
                  Get.back();             
             }
             },
              child: ClipRRect(
               borderRadius: BorderRadius.circular(5),
                child:  Material(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 20),
                   child: Center(
                     child:  uploading? const CircularProgressIndicator(color: Colors.white,):  const Text("Edit location",style: TextStyle(fontSize: 18,
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