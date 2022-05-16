import 'package:busproject/style/style.dart';
import 'package:busproject/adminside/add_member.dart';
import 'package:busproject/adminside/admin_add_location.dart';
import 'package:busproject/adminside/admin_add_page.dart';
import 'package:busproject/screen/accountScreen/account_profile.dart';
import 'package:busproject/screen/chooseScreen/station_detail.dart';
import 'package:busproject/screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late String _username, _firstname, _lastname, _email, _password, _street;
  final _auth = FirebaseAuth.instance;

  final List<Widget> screen = [
    Account(),
    StationDetails(),
    AdminAddStationandMember()
  ];
   int side = 2;
  @override
  Widget build(BuildContext context) {
     final pages = <Widget>[
       Icon(Icons.person, color: busWhite),
       Icon(Icons.directions_bus, color: busWhite),
       Icon(Icons.work_outline_outlined, color: busWhite),
    ];
    return Scaffold(
      extendBody: true,
      body: screen[side],
      bottomNavigationBar: CurvedNavigationBar(
        
        height: 70,
        backgroundColor: Colors.transparent,
        color: busclay,
        index: side,
        items: pages,
        onTap: (index) {
          setState(() {
            side = index;
          });
        },
      ),
    );
  }

  }

class AdminAddPage {
}
