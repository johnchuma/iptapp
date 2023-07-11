import 'package:cloud_firestore/cloud_firestore.dart';

class IPTplaces {
  late String id;
  late String name;
  late String address;
  late double latitude;
  late double longitude;
  
  IPTplaces();
  IPTplaces.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    id = documentSnapshot['id'];
    name = documentSnapshot['name'];
    address = documentSnapshot['address'];
    latitude =double.parse(documentSnapshot['latitude']) ;
    longitude = double.parse(documentSnapshot['longitude']);

  }
}