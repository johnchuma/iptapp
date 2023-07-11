// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iptapp/models/iptplace.dart';
import 'package:iptapp/models/student.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<User?> userController = Rx<User?>(null);
  User? get user => userController.value;
  
  @override
  void onInit() {
    userController.bindStream(auth.authStateChanges());
    super.onInit();
  }

Future<Position?> getUserLocation() async {

  Position? position;
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
   
  if (isLocationServiceEnabled){
    try {
      position = await Geolocator.getLastKnownPosition();
        print("Hey chatGPT, It does not reach here");
      } catch (e) {
        // Handle exception/error here
        print('Error getting current position: $e');
      }
  } else{
    await Geolocator.requestPermission();
    bool permissionGranted = await Geolocator.isLocationServiceEnabled();
    if (permissionGranted) {
      position = await Geolocator.getLastKnownPosition();
    } else {
    }
  }
  return position;
}
bool checkIfUserIsAround(Position? userPosition,IPTplaces ipt){
  double distance = Geolocator.distanceBetween(userPosition!.latitude, userPosition.longitude, ipt.latitude, ipt.longitude);
 print(distance/1000);
  return distance/1000 > 1? false:true; 
}
double distanceFromOrganization(Position? userPosition,IPTplaces ipt){
  double distance = Geolocator.distanceBetween(userPosition!.latitude, userPosition.longitude, ipt.latitude, ipt.longitude);
  return distance; 
}
Future<IPTplaces> findPlaceInfo() async {
  var value = await findUserInfo();
  var snapshot = await firestore.collection("places").doc(value.IPTId).get();
  return IPTplaces.fromDocumentSnapshot(snapshot);
}

Future<Student> findUserInfo() async {
  String? userEmail = auth.currentUser?.email;
  if (userEmail != null) {
    print(userEmail);
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("students")
        .doc(userEmail)
        .get();
    if (snapshot.exists) {
      return Student.fromDocumentSnapshot(snapshot);
    }
  }
  throw Exception("User info not found");
}

  Future signIn(String email,String password) async{
    try {
      await auth.signInWithEmailAndPassword(email:email.toString().trim() , password: password);
    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.white);
    }
  }

  Future logout() async{
    try {
     await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future registerUser(Student student) async{
    try {
      await auth.createUserWithEmailAndPassword(email: student.email.toString().trim(), password: student.password.toString().trim());
      firestore.collection("students").doc(student.email.toString().trim()).set({
        "email":student.email.toString().trim(),
        "name":student.name,
        "reg":student.reg,
        "IPTId":student.IPTId
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.white);
    }
  }
    Future updateLocation(Student student) async{
    try {
      firestore.collection("students").doc(student.email).update({
        "IPTId":student.IPTId
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.white);
    }
  }
}