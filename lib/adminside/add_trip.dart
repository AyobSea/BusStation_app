import 'package:busproject/adminside/admin_home.dart';
import 'package:busproject/screen/home_screen.dart';
import 'package:busproject/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:busproject/screen/chooseScreen/get_station_info.dart';

class AddTrip extends StatefulWidget {
  final String documentID;
  const AddTrip({Key? key, required this.documentID}) : super(key: key);

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  int stationsChanged = 0;

  late String _statiID;

  String selected = 'please select';

  String? from;
  String? to;
  String? distance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('station').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<String> dropdownValues = [];
          Map<String, List<double>> locations = {};

          for (var docs in snapshot.data!.docs) {
            final fields = (docs.data() as Map<String, dynamic>);
            dropdownValues.add(fields['name']);
          }

          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(children: [
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 90),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: DottedBorder(
                            child: Text(
                              widget.documentID,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),
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
                              value: to,
                              onChanged: (newValue) {
                                setState(() {
                                  to = newValue;
                                  CheckLike();
                                });
                              }),
                        ],
                      ),
                    ],
                  )
                ]),
                ElevatedButton(
                    style: firstButton,
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('Trips')
                          .doc()
                          .set({
                        'StartingTrip': widget.documentID,
                        'EndingTrip': to
                      }); 
                      Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AdminHomePage()));
                    },
                    child: Text('Add new trip', style: bText,)),
              ]));
        });
  }

  CheckLike() async {
    if (widget.documentID == to) {
      return showDialog(context: context, builder: (context)
      {
        return AlertDialog(content: Text('Something Wrong happen'),);
      }
      );
        }
    
  
        
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
        height: 50,
        width: 140,
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
          icon: Icon(Icons.arrow_downward, color: Colors.black, size: 10),
          hint: Text(
            'please select',
            style: TextStyle(fontSize: 10),
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
