import 'package:busproject/screen/buses.dart';
import 'package:busproject/screen/new_buses.dart';
import 'package:busproject/useless/dummies.dart';
import 'package:busproject/useless/dummies_direction.dart';
import 'package:busproject/useless/spd_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:busproject/Register/register_styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class StationDetails extends StatefulWidget {

  const StationDetails({Key? key,}) : super(key: key);

  @override
  State<StationDetails> createState() => _StationDetailsState();
}

class _StationDetailsState extends State<StationDetails> {
  final _auth = FirebaseAuth.instance.currentUser;
  // Position? _currentUserPosition;
  double? distanceImMeter = 0.0;
  Data data = Data();

  getDetails(Map singleCityData, BuildContext context) {
    print(singleCityData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleCity(
          cityData:  singleCityData,
        ),
      ),
    );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: busBackground,
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('station').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final stationData = (snapshot.data!.docs);
              // for (var data in stationData) {
              //  final stat = (data.data() as Map<String, dynamic>);
              //  print(stat['name']);
              // }

              // for (var i = 0; i < snapshot.data!.docs.length; i++) {
              //   print(snapshot.data!.docs[i]['name']);
              // }

              return Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: ListView.builder(
                  itemCount: stationData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Card(
                        color: busbottom,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            side: BorderSide(color: busblackBlue, width: 3)),
                        elevation: 5,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  // height: 380,
                                  // width: 420,
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 2))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                        'images/Bus-Stop-scaled.jpg'),
                                  ),
                                ),
                                Center(
                                 
                                ),
                              ],
                            ),
                            Container(
                              height: 65,
                              width: 420,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 30),
                                 SizedBox(
                                    height: 25,
                                    width: 85,
                                    child: Card(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: Text(
                                            stationData[index]['name'],
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  iconButton(
                                    icon: Icon(Icons.directions_bus,
                                        color: Colors.white),
                                        onPressedb: () {Navigator.pushNamed(context, Buses.id);},
                                        
                                  ),
                                  iconButton(
                                    icon: Icon(Icons.share_location,
                                        color: Colors.white),
                                        onPressedb: () {
                                          getDetails(data.station[index], context);
                                          // showSheet();
                                        }
                                  ),
                                  iconButton(
                                    icon: Icon(Icons.device_unknown,
                                        color: Colors.white),
                                        onPressedb: () {
                                         Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const NewBuses()));
                                        },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }));
  }
    Future showSheet() => showSlidingBottomSheet(
    context,
      builder: (context) => SlidingSheetDialog(
          snapSpec: const SnapSpec(
            // initialSnap: 1,
            snappings: [0.2, 0.7, 1],
            // snap: false,
          ),
          headerBuilder: (context, state) {
            return Container(
              color: busyellow,
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
          builder: buildSheet
          )
          );
           Widget buildSheet(context, state) => Material(

      );
          
}

class iconButton extends StatelessWidget {
  const iconButton({
    Key? key,
    required this.icon, 
    required this.onPressedb,
  }) : super(key: key);

  final Icon icon;
  final Function() onPressedb;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        child: icon,
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(5),
          primary: busIcon, // <-- Button color
          onPrimary: Colors.black, // <-- Splash color
        ),
        onPressed: onPressedb,
      ),
    );
  }
}

class stationRow extends StatelessWidget {
  const stationRow({
    Key? key,
    required this.stationName,
    required this.stationDec,
  }) : super(key: key);

  final String stationName;
  final String stationDec;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('name: $stationName '),
        Text('Description: $stationDec '),
      ],
    );
  }
}
