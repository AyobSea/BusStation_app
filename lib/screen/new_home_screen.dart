import 'dart:ui';

import 'package:busproject/style/style.dart';
import 'package:busproject/screen/accountScreen/account_profile.dart';
import 'package:busproject/screen/barcodeScreen/barcode.dart';
import 'package:busproject/screen/chooseScreen/station_detail.dart';
import 'package:busproject/screen/commentsScreen/comments.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {

    int side = 2;

  

  final List<Widget> screen = [
    Account(),
    Comments(),
    NewHome(),
    StationDetails(),
    Barcode(),
  ];
  @override
  Widget build(BuildContext context) {
    
    final pages = <Widget>[
      const Icon(Icons.person, color: Colors.white,),
      const Icon(Icons.comment, color: Colors.white,),
      const Icon(Icons.home, color: Colors.white,),
      const Icon(Icons.search, color: Colors.white,),
      const Icon(Icons.camera_alt, color: Colors.white,),
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(items: pages),
      backgroundColor: busbottom,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            cardIcon(
              cardText: 'Home Page',
              icons: Icon(
                Icons.home,
                size: 80,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            cardIcon(
              cardText: 'User Profile',
              icons: Icon(
                Icons.person,
                size: 80,
              )
            ),
            SizedBox(
              height: 20,
            ),
            cardIcon(
              cardText: 'Comments',
              icons: Icon(
                Icons.comment,
                size: 80,
              )
            ),
            SizedBox(
              height: 20,
            ),
            cardIcon(
              cardText: 'Search',
              icons: Icon(
                Icons.search,
                size: 80,
              )
            ),
            SizedBox(
              height: 20,
            ),
            cardIcon(
              cardText: 'Barcode',
              icons: Icon(
                Icons.camera_alt,
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cardIcon extends StatelessWidget {
  const cardIcon({
    Key? key,
    required this.cardText,
    required this.icons,
  }) : super(key: key);

  final String cardText;
  final Icon icons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      // height: 190,
      child: Card(
        child: DottedBorder(
          
                            strokeWidth: 1,
                                color: busblackBlue,
                                dashPattern: [16, 8],
          child: Row(
            children: [
              // SizedBox(width: 45),
              Container(
                  width: 245,
                  height: 115,
                  decoration: BoxDecoration(
                      color: busclay,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(120),
                          topRight: Radius.circular(120),
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Center(
                      child: Text(
                    cardText,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))),
              // Spacer(),
              Container(
                width: 110,
                height: 110,
                child: icons,
                decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
