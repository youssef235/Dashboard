import 'dart:developer';

import 'package:dashboard/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


String DocsNums ="";


class DashboardScreen extends StatefulWidget {


  static const String id = "dashboard-screen";


  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseServices _services = FirebaseServices();


  @override
  Widget build(BuildContext context) {



    Widget analyticwidget({String? title, String? value}){

      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 200,
          width: 700,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF2B2C3E)
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title! , style: TextStyle(fontSize: 50 , color: Colors.white , fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value! ,
                      style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white , fontSize: 50),
                    ),
                    Icon(Icons.show_chart,color: Colors.white, size: 50,),

                  ],
                )
              ],
            ),
          ),
        ),
      );

    }


    Widget analyticwidget2({String? title, String? value}){

      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF2B2C3E)
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title! , style: TextStyle(fontSize: 20 , color: Colors.white , fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value! ,
                      style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                    ),
                    Icon(Icons.show_chart,color: Colors.white,),

                  ],
                )
              ],
            ),
          ),
        ),
      );

    }


    Widget analyticwidget3({String? title, String? value}){

      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 150,
          width: 550,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF2B2C3E)
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title! , style: TextStyle(fontSize: 30 , color: Colors.white , fontWeight: FontWeight.bold,),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value! ,
                      style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white , fontSize: 30),
                    ),
                    Icon(Icons.show_chart,color: Colors.white, size: 30,),

                  ],
                )
              ],
            ),
          ),
        ),
      );

    }


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 20,

          children: [

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
          stream: _services.users.snapshots() ,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return analyticwidget(title: "ERROR..." , value: snapshot.error.toString());

            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return analyticwidget(title: "Total users" , value: "LOADING...");
            }

            if(snapshot.hasData){
              return analyticwidget(title: "Total users" , value: snapshot.data?.size.toString());
            }
            return SizedBox();

          },
    ),
        ],

      ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _services.Doctors ,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return analyticwidget3(title: "ERROR..." , value: snapshot.error.toString());

                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return analyticwidget3(title: "Doctors" , value: "LOADING...");
                    }

                    if(snapshot.hasData){
                      return analyticwidget3(title: "Doctors" , value: snapshot.data?.size.toString());
                    }
                    return SizedBox();

                  },
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _services.CS ,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return analyticwidget2(title: "ERROR..." , value: snapshot.error.toString());

                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return analyticwidget2(title: "CS students" , value: "LOADING...");
                    }

                    if(snapshot.hasData){
                      return analyticwidget2(title: "CS students" , value: snapshot.data?.size.toString());
                    }
                    return SizedBox();

                  },
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: _services.BUS ,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return analyticwidget2(title: "ERROR..." , value: snapshot.error.toString());

                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return analyticwidget2(title: "Bus students" , value: "LOADING...");
                    }

                    if(snapshot.hasData){
                      return analyticwidget2(title: "Bus students" , value: snapshot.data?.size.toString());
                    }
                    return SizedBox();

                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _services.ENG ,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return analyticwidget2(title: "ERROR..." , value: snapshot.error.toString());

                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return analyticwidget2(title: "Eng students" , value: "LOADING...");
                    }

                    if(snapshot.hasData){
                      return analyticwidget2(title: "Eng students" , value: snapshot.data?.size.toString());
                    }
                    return SizedBox();

                  },
                ),
              ],
            ),


          ],
        ),
      ],
    );
  }
}
