import 'package:dashboard/Screens/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'dashboard.dart';
import 'add_user.dart';

class HomePage extends StatefulWidget {
  static const String id = "home-screen";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Widget _selectedscreen = DashboardScreen();



  currentScreen(item){
    switch(item.route){
      case DashboardScreen.id :
        setState(() {
          _selectedscreen = DashboardScreen();
        });
        break;

      case AddUser.id :
        setState(() {
          _selectedscreen = AddUser();
        });
        break;

      case Users.id :
        setState(() {
          _selectedscreen = Users();
        });
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Color(0xFF212332),
      appBar: AppBar(
        backgroundColor: Color(0xFF212332),
        title: Center(child: const Text('Admin Panel')),
      ),
      sideBar: SideBar(
        backgroundColor: Color(0xFF2B2C3E) ,
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.id,
            icon: Icons.dashboard,

          ),
          AdminMenuItem(
            title: 'Add User',
            route: AddUser.id,
            icon: Icons.add,
          ),
          AdminMenuItem(
            title: 'Users',
            route: Users.id,
            icon: Icons.groups_outlined,
          ),


        ],
        selectedRoute: HomePage.id,
        onSelected: (item) {
          currentScreen(item);

        },
      ),
      body: SingleChildScrollView(
        child: _selectedscreen  ,
      ),
    );
  }
}