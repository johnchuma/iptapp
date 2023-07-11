import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iptapp/models/iptplace.dart';

class PlaceController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<List<IPTplaces>> placesRx =  Rx<List<IPTplaces>>([]);
  List<IPTplaces> get places => placesRx.value;

  @override
  void onInit() {
    placesRx.bindStream(getPlaces());
    super.onInit();
  }

  Stream<List<IPTplaces>> getPlaces (){
    return firestore.collection("places").snapshots().map((snapshots) {
      List<IPTplaces> iptPlaces = [];
      for (var documentSnapshot in snapshots.docs) {
            iptPlaces.add(IPTplaces.fromDocumentSnapshot(documentSnapshot));
       }
       return iptPlaces;
    });
  }



}