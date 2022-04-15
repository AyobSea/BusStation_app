import 'dart:math';

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
  final addressCountryController = TextEditingController();

    @override
  void dispose() {
    addressCountryController.dispose();
    super.dispose();
  }

  String selected = 'please select';
  String holder = '';

  

  String? from;
  String? to;
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

            return SlidingSheet(
              elevation: 8,
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                snap: true,
                snappings: [0.4, 0.7, 1.0],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),

              headerBuilder: (context, state) {
                return Container(
                  color: busIcon,
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: busblackBlue
                  //   )
                  // ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: Container(
                          height: 8,
                          width: 32,
                          // color: Colors.green,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                );
              },
              // The body widget will be displayed under the SlidingSheet
              // and a parallax effect can be applied to it.
              body: Center(
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
                                            ),),),
                                    SelectStation(
                                        // selected: selected,
                                        dropdownValues: dropdownValues,
                                        value: from,
                                        onChanged: (newValue){
                                          setState(() {
                                            from = newValue;

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
                                            ),),),
                                    SelectStation(
                                      // selected: selected,
                                      dropdownValues: dropdownValues,
                                      value: to,
                                      onChanged: (String? newValue) {
                                        to = newValue as String;
                                      }
                                      
                                    ),
                                  ],
                                )
                              ],
                            ),
                            selectDate(
                                selected: selected,
                                dropdownValues: dropdownValues),
                            Container(
                              color: Color(0xffFFF7EE),
                              height: 500,
                              child: Center(
                                  // child: Text(from)
                                      ),
                            ),
                            
                          ],
                        ),
                      ),
                    ]),
              ),
              builder: (context, state) {
                // This is the content of the sheet that will get
                // scrolled, if the content is bigger than the available
                // height of the sheet.
                return Container();
              },
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
    required this.onChanged, required this.value,
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
