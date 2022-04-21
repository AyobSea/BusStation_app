import 'dart:math';
import 'dart:ui';

import 'package:busproject/Register/register_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class NewBuses extends StatefulWidget {
  const NewBuses({Key? key}) : super(key: key);

  @override
  State<NewBuses> createState() => _NewBusesState();
}

class _NewBusesState extends State<NewBuses> {
  final _auth = FirebaseAuth.instance.currentUser;

  int stationsChanged = 0;


  String selected = 'please select';

  String? from;
  String? too;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('station').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            List<String> dropdownValues = [];

            for (var docs in snapshot.data!.docs) {
              dropdownValues.add((docs.data() as Map<String, dynamic>)['name']);
            }

            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 120),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'From : ',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ),
                                    SelectStation(
                                      // selected: selected,
                                      dropdownValues: dropdownValues,
                                      value: from,
                                      onChanged: (newValue) {
                                        setState(() {
                                          from = newValue;
                                          stationsChanged =  Random().nextInt(11 - 1);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 120),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'To :',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ),
                                    SelectStation(
                                        // selected: selected,
                                        dropdownValues: dropdownValues,
                                        value: too,
                                        onChanged: (newValue) {
                                          setState(() {
                                            too = newValue;
                                            stationsChanged =  Random().nextInt(6 - 1);
                                          });
                                        }),
                                  ],
                                )
                              ],
                            ),
                            selectDate(
                                selected: selected,
                                dropdownValues: dropdownValues),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft:  Radius.circular(40), topRight: Radius.circular(40)),
                          color: busclay
                        ),
                        child: ListView.builder(
                        itemCount: 1 + stationsChanged,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Row(
                              children: [
                                SizedBox(width: 80),
                                Text(from ?? 'from',
                                    style: TextStyle(fontSize: 26, color: Colors.white)),
                                SizedBox(width: 20),
                                Text(too ?? 'too', 
                                style: TextStyle(fontSize: 26, color: Colors.white)),
                                SizedBox(width: 90),
                                ElevatedButton(onPressed: () {}, child: Text('ujf'))
                              ],
                            ),
                          );
                        }),
                      ),)
                    ]),
              
             
            );
          }),
    );
  }
}

class SelectStation extends StatelessWidget {
  const SelectStation({
    Key? key,
    // required this.selected,
    required this.dropdownValues,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final Function(String?) onChanged;
  // final String selected;
  final String? value;
  final List<String> dropdownValues;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 90,
        width: 170,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffDFE0DF),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
          ),
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          icon: Icon(Icons.arrow_downward, color: Colors.black, size: 20),
          hint: Text(
            'please select',
            style: TextStyle(fontSize: 14),
          ),
          value: value,
          items: dropdownValues.map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          // onChanged: (String? value) {

          // },
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class selectDate extends StatelessWidget {
  const selectDate({
    Key? key,
    required this.selected,
    required this.dropdownValues,
  }) : super(key: key);

  final String selected;
  final List<String> dropdownValues;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 90,
        width: 360,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffDADDE2),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
          ),
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          icon: Icon(Icons.arrow_downward, color: Colors.black, size: 20),
          hint: Text(
            selected,
            style: TextStyle(fontSize: 14),
          ),
          // value: selected,
          items: dropdownValues.map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: (String? newValue) {
            // setState(() {
            //   selected = newValue!;
            // });
          },
        ),
      ),
    );
  }
}
