// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/report.dart';


class ReportController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<User?> userController = Rx<User?>(null);
  User? get user => userController.value;
  
   Rx<List<Report>> reportsRx =  Rx<List<Report>>([]);
  List<Report> get reports => reportsRx.value;

  @override
  void onInit() {
    reportsRx.bindStream(getReports());
    super.onInit();
  }

  Stream<List<Report>> getReports (){
    return firestore.collection("reports").where("studentId",isEqualTo: auth.currentUser?.email).snapshots().map((snapshots) {
      List<Report> report = [];
      for (var documentSnapshot in snapshots.docs) {
            report.add(Report.fromDocumentSnapshot(documentSnapshot));
       }
       return report;
    });
  }
  Future addReport(Report report) async{
    try {
      var id = Timestamp.now();
      firestore.collection("reports").doc(id.toDate().toLocal().toString()).set({
        "id":id.toDate().toLocal().toString(),
        "studentId":report.studentId,
        "IPTId":report.IPTId,
        "description":report.description,
        "title":report.title
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.white);
    }
  }

  Future EditReport(Report report) async{
    try {
      print(report.description);
      firestore.collection("reports").doc(report.id).update({
        "description":report.description,
        "title":report.title
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.white);
    }
  }
  



}