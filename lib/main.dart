import 'package:dashboard/Screens/add_user.dart';
import 'package:dashboard/Screens/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/HomePage.dart';
import 'Screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
        apiKey: "AIzaSyDin2x1OZrwdNsixzzjR3K18VVy3baQMJo",
        authDomain: "flutterchat-1258f.firebaseapp.com",
        projectId: "flutterchat-1258f",
        storageBucket: "flutterchat-1258f.appspot.com",
        messagingSenderId: "702071822619",
        appId: "1:702071822619:web:72d6fd2ee61c7ce17ddbbe",
        measurementId: "G-E0D702ETHJ"
    ),
  );

  runApp(MyApp());


}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool userIsLoggedIn = false;


  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      //  primaryColor: Color(0xffffffff),
      //  scaffoldBackgroundColor: Color(0xff1F1F1F),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute : HomePage.id,
      routes: {
        HomePage.id : (context) => HomePage(),
        DashboardScreen.id : (context) => DashboardScreen(),
        AddUser.id : (context) => AddUser(),
        Users.id : (context) => Users(),

      },

    );
  }
}
