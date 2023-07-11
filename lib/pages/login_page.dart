// ignore_for_file: sort_child_properties_last, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';
import 'package:iptapp/pages/registration_page.dart';
import 'package:iptapp/pages/waypage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   var selectedIPT = "";
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   bool uploading = false;
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: AppBar(backgroundColor: Color.fromARGB(255, 116, 15, 15),
      title:const Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
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
              backgroundColor: const Color.fromARGB(230, 0, 0, 0),
              drawer:  Drawer(child: Column(children: [
                const SizedBox(height: 200,),
                Container(height: 50,width:100,color: Colors.red,),
                GestureDetector(
                  onTap: (){
                    AuthController().logout();
                  },
                  child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Logout",style: TextStyle(color: Colors.red),),
                    )))],),),
             
              body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
          const SizedBox(height:20,),
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
            
             
            
             const SizedBox(height:30),
          
            GestureDetector(
             onTap: () {
             
             if(_formKey.currentState!.validate()){
               final email = emailController.text;
               final password = passwordController.text;
                setState(() {
                  uploading = true;
                });
                AuthController().signIn(email, password).then((value){
                  setState(() {
                    uploading = false;
                        Get.to(()=>const WayPage());

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
                     child:  uploading? const CircularProgressIndicator(color: Colors.white,):  const Text("Login",style: TextStyle(fontSize: 18,
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
                                  const Text("Don't have an account ?  ",style: TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.normal),),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>const RegistrationPage());
                                    },
                                    child:const Text("Register",style: TextStyle(fontSize: 14,color: Colors.red, fontWeight: FontWeight.bold),)),
             
             ],),
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