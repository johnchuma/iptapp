// ignore_for_file: unused_import, non_constant_identifier_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';
AuthController authController = Get.put(AuthController());
class Report {
  late String title;
  late String id;

  late String description;
  late String? studentId = authController.auth.currentUser!.email;
  late String? IPTId ;

  Report(this.title,this.description,this.IPTId);
  Report.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    title = documentSnapshot['title'];
    id = documentSnapshot['id'];
    description = documentSnapshot['description'];
    studentId = documentSnapshot['studentId'];
    IPTId = documentSnapshot['IPTId'];
  }
}
