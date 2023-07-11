// ignore_for_file: sort_child_properties_last, unused_import, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';
import 'package:iptapp/controllers/place_controller.dart';
import 'package:iptapp/models/student.dart';
import 'package:iptapp/pages/home_page.dart';
import 'package:iptapp/pages/login_page.dart';
import 'package:iptapp/pages/waypage.dart';
import 'package:iptapp/utils/colors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
   var selectedIPT = "";
   TextEditingController nameController = TextEditingController();
   TextEditingController regController = TextEditingController();

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController confirmationController = TextEditingController();
   bool uploading = false;
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
         
              appBar: AppBar(backgroundColor: const Color.fromARGB(255, 116, 15, 15),
      title:const Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
              body: SingleChildScrollView(
          child: GetX<PlaceController>(
            init: PlaceController(),
            builder: (find) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                 const SizedBox(height:20),
        
             DropdownButtonFormField<String>(
               value: selectedIPT,
               onChanged: (newValue) {
                 setState(() {
                   selectedIPT = newValue!;
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
               items:  [
                 const DropdownMenuItem<String>(
                   value: "",
                   child: Text("Select IPT organisation/company",style: TextStyle(fontWeight: FontWeight.normal),),
                 ),
                 ...find.places.map((place) =>DropdownMenuItem<String>(
                   value: place.id,
                   child: Text(place.name,style: const TextStyle(fontWeight: FontWeight.normal),),
                 )),
               ],
               ),
              const SizedBox(height:10),
              TextFormField(
               style: const TextStyle(color: Colors.white),
               controller: nameController,
               validator: (value){
                 if(value!.isEmpty){
                   return "Enter your name";
                 }
                 return null;
                 
               },
               decoration: const InputDecoration(
               border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
               enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               labelStyle: TextStyle(color: Colors.white60),
               labelText: "Enter your name"
               )),
                  const SizedBox(height:10),
              TextFormField(
               style: const TextStyle(color: Colors.white),
               controller: regController,
               validator: (value){
                 if(value!.isEmpty){
                   return "Enter your registration number";
                 }
                 return null;
                 
               },
               decoration: const InputDecoration(
               border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
               enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               labelStyle: TextStyle(color: Colors.white60),
               labelText: "Registration number"
               )),
                 
              const SizedBox(height:10,),
                   TextFormField(
               style: const TextStyle(color: Colors.white),
               controller: emailController,
                validator: (value){
                 if(value!.isEmpty){
                   return "Enter your  email";
                 }
                 return null;
                 
               },
               decoration: const InputDecoration(
               border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
               enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               labelStyle: TextStyle(color: Colors.white60),
              
               labelText: "Enter your email"
               )),
              const SizedBox(height:10,),
             
                 TextFormField(
               style: const TextStyle(color: Colors.white),
               obscureText: true,
               controller: passwordController,
                validator: (value){
                 if(value!.isEmpty){
                   return "Enter password";
                 }
                 return null;
                 
               },
               decoration: const InputDecoration(
               border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
               // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
             
               labelStyle: TextStyle(color: Colors.white60),
               labelText: "Enter your password"
               )),
                 const SizedBox(height:10,),
             
                 TextFormField(
                   controller: confirmationController,
               style: const TextStyle(color: Colors.white),
               
               obscureText: true,
              validator: (value){
                 if(value!.isEmpty){
                   return "Confirm password";
                 }
                 if(value != passwordController.text){
                   return "Password does not match ";
                 }
                 return null;
                 
               },
               decoration: const InputDecoration(
               border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
               // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
               enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
             
               labelStyle: TextStyle(color: Colors.white60),
               labelText: "Repeat your password"
               )),
                 const SizedBox(height:30),
              
                GestureDetector(
                 onTap: () {
                 
                 if(_formKey.currentState!.validate()){
                   final name = nameController.text;
                   final IPTId = selectedIPT;
                   final email = emailController.text;
                   final reg = regController.text;
                   final password = passwordController.text;
                    var student =  Student(name,reg,email,IPTId,password);
                    setState(() {
                      uploading = true;
                    });
                    AuthController().registerUser(student).then((value){
                      setState(() {
                        uploading = false;
                        Get.to(()=>const WayPage());
                      });
                    });
                   // final confirmation = confirmationController.text;
                 
             
                 
                 }
                 },
                  child: ClipRRect(
                   borderRadius: BorderRadius.circular(5),
                    child:  Material(
                 
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 20),
                       child: Center(
                         child:  uploading? const CircularProgressIndicator(color: Colors.white,):  const Text("Register",style: TextStyle(fontSize: 18,
                                     color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                       ),
                     ),
                    color:Colors.green ),
                  ),
                )
              ,
                 const SizedBox(height: 20,),
                   Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                                      const Text("Already registered ?  ",style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.normal),),
          
                 
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(()=>const LoginPage());
                                        },
                                        child: const Text("Login",style: TextStyle(fontSize: 15,color: Colors.red, fontWeight: FontWeight.bold),)),
                 
                 ],),
                 const SizedBox(height: 20,),
          
                ],),
              );
            }
          ),
              ),
            ))
            ],
          ),
        ),
      );
    
    
    
     
  }
}