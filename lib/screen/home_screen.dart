import 'package:busproject/screen/account_profile.dart';
import 'package:busproject/Register/register_styles.dart';
import 'package:busproject/screen/new_buses.dart';
import 'package:busproject/useless/chooselocation.dart';
import 'package:busproject/screen/comments.dart';
import 'package:busproject/useless/dummies_detail.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'station_detail.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int side = 1;

  

  final List<Widget> screen = [
    Comments(),
    StationDetails(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const Icon(Icons.home, color: Colors.white,),
      const Icon(Icons.search, color: Colors.white,),
      const Icon(Icons.person, color: Colors.white,),
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
