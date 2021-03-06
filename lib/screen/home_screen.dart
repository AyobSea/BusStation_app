import 'package:busproject/screen/accountScreen/account_profile.dart';
import 'package:busproject/screen/chooseScreen/trips_details.dart';
import 'package:busproject/style/style.dart';
import 'package:busproject/screen/barcodeScreen/barcode.dart';
import 'package:busproject/screen/chooseScreen/station_detail.dart';
import 'package:busproject/screen/commentsScreen/comments.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int side = 2;

  

  final List<Widget> screen = [
    Account(),
    Comments(),
    Barcode(),
    StationDetails(),
    tripsDetails(),
  ];
    final pages = <Widget>[
      const Icon(Icons.person, color: Colors.white,),
      const Icon(Icons.question_answer, color: Colors.white,),
      const Icon(Icons.camera_alt, color: Colors.white,),
      const Icon(Icons.info, color: Colors.white,),
      const Icon(Icons.search, color: Colors.white,),
    ];
  @override
  Widget build(BuildContext context) {

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