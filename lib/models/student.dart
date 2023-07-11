// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  late String name;
  late String reg;
  late String email;
  late String IPTId;
  late String password;
  
  Student(this.name,this.reg,this.email,this.IPTId,this.password);
  Student.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    name = documentSnapshot['name'];
    reg = documentSnapshot['reg'];
    email = documentSnapshot['email'];
    IPTId = documentSnapshot['IPTId'];
  }
}