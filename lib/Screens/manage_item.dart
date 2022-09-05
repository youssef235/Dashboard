import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageItem extends StatelessWidget {

  static const String id = "manage-item-screen";

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Manage Items Screen" , style : TextStyle(fontSize: 30 , color: Colors.white)),);
  }
}
