import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';

import 'package:busproject/screen/home_screen.dart';
import 'package:busproject/style/style.dart';
import 'package:busproject/useless/buses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class tripsDetails extends StatefulWidget {
  const tripsDetails({Key? key}) : super(key: key);

  @override
  State<tripsDetails> createState() => _tripsDetailsState();
}

class _tripsDetailsState extends State<tripsDetails> {
  final _auth = FirebaseAuth.instance.currentUser;

  final List <Widget>tripCards = [];

  int stationsChanged = 0;

  String selected = 'please select';

  String? from;
  String? to;
  String? distance;

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  double? lat1, lon1, lat2, lon2;

  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat1)) *
            math.cos(deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (math.pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: busBackground,
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
            Map<String, List<double>> locations = {};

            for (var docs in snapshot.data!.docs) {
              final fields = (docs.data() as Map<String, dynamic>);
              dropdownValues.add(fields['name']);
              locations[fields['name']] = [
                fields['latitude'],
                fields['longitude']
              ];
            }
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
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
                                    onChanged: (newValue) async {
                                      from = newValue;
                                      stationsChanged = Random().nextInt(5) + 1;
                                      if (from != null && to != null) {
                                        distance = getDistanceFromLatLonInKm(
                                                locations[from]![0],
                                                locations[from]![1],
                                                locations[to]![0],
                                                locations[to]![1])
                                            .toStringAsFixed(2);
                                      }
                                      await getTrips();
                                      setState(() {});
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
                                      value: to,
                                      onChanged: (newValue) async {
                                          to = newValue;
                                          stationsChanged =
                                              Random().nextInt(5) + 1;
                                          if (from != null && to != null) {
                                            distance =
                                                getDistanceFromLatLonInKm(
                                                        locations[from]![0],
                                                        locations[from]![1],
                                                        locations[to]![0],
                                                        locations[to]![1])
                                                    .toStringAsFixed(2);
                                          }
                                          await getTrips();
                                        setState(() {
                                          
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xffDFE0DF),
                                      onPrimary: Colors.black,
                                      side: BorderSide(
                                          width: 1, color: Colors.black)),
                                  onPressed: () {
                                    _selectTime();
                                  },
                                  child: Row(
                                    children: [
                                      Text('Select trip time'),
                                      Icon(Icons.arrow_right)
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 160,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Color(0xffDFE0DF),
                                    border: Border.all(
                                        color: busblackBlue, width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _time.format(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(distance != null
                              ? '$distance KM to readh distination'
                              : '')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: test),
                            child: tripCards.isNotEmpty? ListView.builder(itemBuilder: (context, index) => tripCards[index], itemCount: tripCards.length): Center(child: Text('No Trips Availble', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                        
                      ),
                    )
                  ]),
            );
          }),
    );
  }

  Future<void> getTrips() async {
    final selectedTrip = await FirebaseFirestore.instance
        .collection('Trips')
        .where('StartingTrip', isEqualTo: from).where('EndingTrip', isEqualTo: to)
        .get();
        tripCards.clear();
    for (var trips in selectedTrip.docs) {
      tripCards.add(
        Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 480,
              width: 380,
              child: Card(
                child: DottedBorder(
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          trips.data()['StartingTrip'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          trips.data()['EndingTrip'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(' ExpectedTime : '),
                        Text(
                          trips.data()['ExpectedTime'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ),
          ),
        )
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

class getTripsData extends StatelessWidget {
  const getTripsData({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  final String data;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          type,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
