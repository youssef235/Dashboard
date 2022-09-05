import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/services/auth.dart';
import 'package:dashboard/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_switch/flutter_switch.dart';




class AddUser extends StatefulWidget {


   static const String id = "add-user-screen";

  @override
  State<AddUser> createState() => _AddUserState();
}

enum Type { Engineering , CS , Business }

class _AddUserState extends State<AddUser> {

Type? _type = null;
TextEditingController emailEditingController = new TextEditingController();
TextEditingController passwordEditingController = new TextEditingController();
TextEditingController usernameEditingController = new TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;
AuthService authService = new AuthService();
DatabaseMethods databaseMethods = new DatabaseMethods();
final FS = FirebaseFirestore.instance;

//final formKey = GlobalKey<FormState>();
GlobalKey<FormState> formKey = GlobalKey();


bool isLoading = false;
bool isaDoctor = false;


getSwitchValues() async {
  isaDoctor = (await getSwitchState())!;
  setState(() {});
}

Future<bool> saveSwitchState(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("switchState", value);
  log('Switch Value saved $value');
  return prefs.setBool("switchState", value);
}

Future<bool?> getSwitchState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isaDoctor = prefs.getBool("switchState");
  print(isaDoctor);

  return isaDoctor;
}


// @protected
// @mustCallSuper
// void initState() {
//
//   log(_auth.currentUser!.displayName.toString());
//
// }

singUp() async {

  if(formKey.currentState!.validate()){
    setState(() {

      isLoading = true;

    });



      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){


        if(result != null){


_auth.currentUser!.updateDisplayName(usernameEditingController.text);


          Map<String,dynamic> userDataMap = {
            "name" : usernameEditingController.text,
            "email" : emailEditingController.text,
            "userId": _auth.currentUser!.uid,
            "password" :  passwordEditingController.text,
            "Doctor": isaDoctor ,
            "StudintT" : _type.toString(),
            'userStatus' : "Online",
            'chatWith': "",
            'displayname' : usernameEditingController.text
          };


          usernameEditingController.clear();
          emailEditingController.clear();
          passwordEditingController.clear();

          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('User added successfully'),
              //  content: const Text('AlertDialog description'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );


          FS.collection("users").doc(_auth.currentUser?.uid).set(userDataMap).catchError((e){
            log("The error is **************" + e + "**************************");
          });


        }
      });










 }
}
@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: usernameEditingController,
                validator: (val){
                  return val!.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter username',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: emailEditingController,
                validator: (val){
                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                  null : "Enter correct email";
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: passwordEditingController,
                validator:  (val){
                  return val!.length < 6 ? "Enter Password 6+ characters" : null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),


          ],
        ),

      ),
      SizedBox(height: 20),
      Form(
      child: Row(
  children: [


    SizedBox(width : 5.0),

    Text("Student" , textScaleFactor: 1.2 , style: TextStyle(
            fontWeight: FontWeight. bold,color: Colors.white),),

        //    TextStyle(fontSize: 15),
        SizedBox(width : 10.0),
        FlutterSwitch(

          height: 40.0,
          width: 80.0,
          padding: 10.0,
          toggleSize: 25.0,
          borderRadius: 20.0,
          value: isaDoctor,

          onToggle: (bool value) {
            if(isaDoctor){
              _type = null;
            }
            setState(() {
              isaDoctor = value;
              saveSwitchState(value);
              log('Saved state is $isaDoctor');
              //switch works
            });
            print(isaDoctor);
          },
        ),
    SizedBox(width : 10.0),

    Text("Doctor" , textScaleFactor: 1.2 , style: TextStyle(
        fontWeight: FontWeight. bold,color: Colors.white),),

  ],
      ),

      ),
Visibility(
  visible: !isaDoctor,

  child:
      Form(
          //key: formKey,
          child: Column(
          children: [
            ListTile(
                title: const Text('Engineering',style: TextStyle(
                    fontWeight: FontWeight. bold,color: Colors.white)),
                leading: Radio<Type>(
                  value: Type.Engineering,
                  groupValue: _type,
                  onChanged: (Type? value) {
                    setState(() {
                      _type = value ;
                    });
                  },
                )
            ),
            ListTile(
                title: const Text('Computer Science',style: TextStyle(
                    fontWeight: FontWeight. bold,color: Colors.white)),
                leading: Radio<Type>(
                  value: Type.CS,
                  groupValue: _type,
                  onChanged: (Type? value) {
                    setState(() {
                      _type = value ;
                    });
                  },
                )
            ),
            ListTile(
                title: const Text('Business',style: TextStyle(
                    fontWeight: FontWeight. bold,color: Colors.white)),
                leading: Radio<Type>(
                  value: Type.Business,
                  groupValue: _type,
                  onChanged: (Type? value) {
                    setState(() {
                      _type = value ;
                    });
                  },
                )
            ),


          ],
          ),
      ),
),
      SizedBox(height : 40.0),

      Align(
      alignment: Alignment.center,
      child:
      ElevatedButton(

        onPressed: () {singUp();},
        child: const Text("ADD USER"
        ,            style: TextStyle(color: Colors.white, fontSize: 18 , fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
           // shadowColor: Colors.red,
           // onSurface: Colors.black,
         //   side: BorderSide(color: Colors.red, width: 5),
            primary:  Color(0xFF313246),
            fixedSize: const Size(300, 70),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
        ),

      )


      ),

    ],

  );
}
}
