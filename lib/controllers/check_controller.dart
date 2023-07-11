// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';

import '../models/Check.dart';


class CheckController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  
   Rx<List<Check>> checksRx =  Rx<List<Check>>([]);
  List<Check> get checks => checksRx.value;

  @override
  void onInit() {
    checksRx.bindStream(getchecks());
    super.onInit();
  }

  Stream<List<Check>> getchecks (){
    return firestore.collection("checks").where("studentId",isEqualTo:auth.currentUser?.email).snapshots().map((snapshots) {
      List<Check> check = [];
      for (var documentSnapshot in snapshots.docs) {
            check.add(Check.fromDocumentSnapshot(documentSnapshot));
       }
       return check;
    });
  }



Future<bool> checkIfTodayCheckInExists() async {
  // print("Hello there");
  DateTime today = DateTime.now();
  DateTime todayStart = DateTime(today.year, today.month, today.day);
  DateTime todayEnd = todayStart.add(const Duration(days: 1));
  Timestamp startTimestamp = Timestamp.fromDate(todayStart);
  Timestamp endTimestamp = Timestamp.fromDate(todayEnd);
  var user =await AuthController().findUserInfo();

  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection('checks')
      .where('checkin', isGreaterThanOrEqualTo: startTimestamp, isLessThan: endTimestamp)
      .where("studentId",isEqualTo:user.email )
      .get();

  return snapshot.docs.isNotEmpty;
}
Future<Check> getTodayCheckIn() async {
  DateTime today = DateTime.now();
  DateTime todayStart = DateTime(today.year, today.month, today.day);
  DateTime todayEnd = todayStart.add(const Duration(days: 1));
  Timestamp startTimestamp = Timestamp.fromDate(todayStart);
  Timestamp endTimestamp = Timestamp.fromDate(todayEnd);
  var user =await AuthController().findUserInfo();
  QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseFirestore.instance
      .collection('checks')
      .where('checkin', isGreaterThanOrEqualTo: startTimestamp, isLessThan: endTimestamp)
      .where("studentId",isEqualTo:user.email )
      .get();     
  DocumentSnapshot firstDocument = snapshots.docs.first;
  Check check = Check.fromDocumentSnapshot(firstDocument);
  return check;
}


Future<bool> checkIfTodayCheckOutExists() async {
  DateTime today = DateTime.now();
  DateTime todayStart = DateTime(today.year, today.month, today.day);
  DateTime todayEnd = todayStart.add(const Duration(days: 1));
  Timestamp startTimestamp = Timestamp.fromDate(todayStart);
  Timestamp endTimestamp = Timestamp.fromDate(todayEnd);
  var user =await AuthController().findUserInfo();
   QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection('checks')
      .where('checkout', isGreaterThanOrEqualTo: startTimestamp, isLessThan: endTimestamp)
      .where("studentId",isEqualTo:user.email )
      .get();
  return snapshot.docs.isNotEmpty;
}

  Future checkin(Check check) async{
    try {
     await firestore.collection("checks").doc(check.id).set({
        "id":check.id,
        "studentId":check.studentId,
        "IPTId":check.IPTId,
        "checkin":Timestamp.now(),
        "checkout":null
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.white);
    }
  }

   Future checkout() async{
    try {
     Check todayCheck = await getTodayCheckIn();
     await firestore.collection("checks").doc(todayCheck.id).update({
        "checkout":Timestamp.now()
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.white);
    }
  }
}