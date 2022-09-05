import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



final _auth = FirebaseAuth.instance;


class FirebaseServices {

  User? user = FirebaseAuth.instance.currentUser;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
   Stream<QuerySnapshot<Map<String, dynamic>>> Doctors = FirebaseFirestore.instance.collection('users')
                                             .where("Doctor" , isEqualTo: true).get().asStream();
  Stream<QuerySnapshot<Map<String, dynamic>>> CS = FirebaseFirestore.instance.collection('users')
                                              .where("StudintT" , isEqualTo: "Type.CS").get().asStream();
  Stream<QuerySnapshot<Map<String, dynamic>>> BUS = FirebaseFirestore.instance.collection('users')
                                               .where("StudintT" , isEqualTo:"Type.Business").get().asStream();
  Stream<QuerySnapshot<Map<String, dynamic>>> ENG = FirebaseFirestore.instance.collection('users')
                                               .where("StudintT" , isEqualTo:"Type.Engineering").get().asStream();




}



class FireStoreDataBase {
  List UsersList = [];
  final CollectionReference collectionRef =
  FirebaseFirestore.instance.collection("users");

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          UsersList.add(result.data());
        }
      });

      return UsersList;
    } catch (e) {
      log("Error - $e");
      return null;
    }
  }
}

class DatabaseMethods {

  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance.collection("users").doc(_auth.currentUser?.uid).set(userData).catchError((e) {
      log(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }





}
