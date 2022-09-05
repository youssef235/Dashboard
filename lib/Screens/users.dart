import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/services/auth.dart';
import 'package:dashboard/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Users extends StatefulWidget {

  static const String id = "users-screen";

  final formKey = GlobalKey<FormState>();


  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {

  List dataList = [];
  String Type="";
  bool _status = true;



  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            child: Column(
              children: [

                FutureBuilder(
                  future: FireStoreDataBase().getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                        "Something went wrong",
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      dataList = snapshot.data as List;
                      return buildItems(dataList);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],

            ),

          )
        ]
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
 if(dataList[index]["Doctor"]==true){

   Type = "Doctor";
 }else{
   Type = "Student";
 }

        return Card(
          color: Color(0xFF2B2C3E),
          child:
          // ListTile(
          //   title: TextField(
          //     decoration:  InputDecoration(
          //       hintText: dataList[index]["name"],//getUserName(),
          //     ),
          //     enabled: !_status,
          //     autofocus: !_status,
          //   ),
          //   subtitle: TextField(
          //     decoration:  InputDecoration(
          //       hintText: dataList[index]["email"],//getUserName(),
          //     ),
          //     enabled: !_status,
          //     autofocus: !_status,
          //   ),
          //   trailing: TextField(
          //     decoration:  InputDecoration(
          //       hintText: Type,//getUserName(),
          //     ),
          //     enabled: !_status,
          //     autofocus: !_status,
          //   ),
          // ),
          ListTile(
            leading:  IconButton( color: Colors.red, icon: const Icon(Icons.delete),
                 onPressed: () {

                   showDialog<String>(
                     context: context,
                     builder: (BuildContext context) => AlertDialog(
                       title: const Text('Sure to delete the user?'),
                       //  content: const Text('AlertDialog description'),
                       actions: <Widget>[
                         Row(
                           children: [
                             TextButton(
                               onPressed: (){
                                 FirebaseFirestore.instance
                                     .collection("users")
                                     .where("email", isEqualTo : dataList[index]["email"])
                                     .get().then((value){
                                   value.docs.forEach((element) {
                                     FirebaseFirestore.instance.collection("users").doc(element.id).delete().then((value){
                                       Navigator.pop(context, 'OK');
                                       showDialog<String>(
                                         context: context,
                                         builder: (BuildContext context) => AlertDialog(
                                           title: const Text('User Deleted successfully, please refresh the page so that the deleted username disappears'),
                                           //  content: const Text('AlertDialog description'),
                                           actions: <Widget>[
                                             TextButton(
                                               onPressed: () => Navigator.pop(context, 'OK'),
                                               child: const Text('OK'),
                                             ),
                                           ],
                                         ),
                                       );


                                     });
                                   });
                                 });
                               },
                               child: const Text('OK'),
                             ),
                             TextButton(
                               onPressed: () => Navigator.pop(context, 'Cancel'),
                               child: const Text('Cancel'),
                             ),
                           ],
                         ),
                       ],
                     ),
                   );


            }
            ),
            title: Text("Name :  "+dataList[index]["name"], style: TextStyle(color: Colors.white)),
              subtitle:  Text("Email :  "+dataList[index]["email"], style: TextStyle(color: Colors.white)),
               trailing: Text(Type ,style: TextStyle(color: Colors.white)),

          ),
        );
      });


}