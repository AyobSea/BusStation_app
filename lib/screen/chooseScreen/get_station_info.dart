import 'package:busproject/style/style.dart';
import 'package:busproject/screen/chooseScreen/station_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dotted_border/dotted_border.dart';

class GetStationsInfo extends StatefulWidget {
  final String documentID;
  const GetStationsInfo({Key? key, required this.documentID}) : super(key: key);

  @override
  State<GetStationsInfo> createState() => _GetStationsInfoState();
}

class _GetStationsInfoState extends State<GetStationsInfo> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('station')
            .doc(widget.documentID)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final stationDetailsData =
              (snapshot.data!.data() as Map<String, dynamic>);
              
          return Padding(
            padding: EdgeInsets.all(5),
            child: DottedBorder(
              color: busIcon,
              dashPattern: [16, 8],
              strokeWidth: 2,
              strokeCap: StrokeCap.round,
              child: Container(
                color: busclay,
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // height: 380,
                        // width: 420,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2))),
                        child: ClipRRect(
                          child: Image.asset('images/Bus-Stop-scaled.jpg'),
                        ),
                      ),
                      SizedBox(height: 12,),
                      stationInfo(
                        stationName: 'Station Name: ',
                        theName: stationDetailsData['name'],
                      ),
                      SizedBox(height: 12,),
                      stationInfo(
                        stationName: 'Station Landmark: ',
                        theName: stationDetailsData['nearby'],
                      ),
                      SizedBox(height: 12,),
                      stationInfo(
                          stationName: 'Station ID: ',
                          theName: stationDetailsData['statID']),
                      SizedBox(height: 12,),
                      stationInfo(
                        stationName: 'Station street: ',
                        theName: stationDetailsData['street'],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class stationInfo extends StatelessWidget {
  const stationInfo({
    Key? key,
    required this.stationName,
    required this.theName,
  }) : super(key: key);

  final String stationName;
  final String theName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: DottedBorder(
              padding: EdgeInsets.all(12),
        color: Colors.white,
              dashPattern: [24, 12],
        child: Row(
          children: [
            Text(
              stationName,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, ),
            ),
            Text(
              theName,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
