// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:iptapp/controllers/auth_controller.dart';

AuthController authController = Get.put(AuthController());
var time = Timestamp.now();
class Check{
  late String? id = time.toDate().toLocal().toString();
  late String? studentId = authController.auth.currentUser!.email;
  late Timestamp checkin;
  late  Timestamp checkout;
  late String IPTId;

  Check(this.IPTId);
  Check.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    id = documentSnapshot["id"];
    studentId = documentSnapshot["studentId"];
    checkin = documentSnapshot["checkin"];
    if(documentSnapshot['checkout'] != null){
    checkout = documentSnapshot["checkout"];
    }
    IPTId = documentSnapshot["IPTId"];

  }
}