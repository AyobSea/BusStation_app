import 'package:busproject/style/style.dart';
import 'package:busproject/adminside/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
import 'dart:math' as math;

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final _auth = FirebaseAuth.instance;
  late String _stationName, _stationStr, _statNearby, _statID;
  final loc.Location location = loc.Location();
  // StreamSubscription<loc.LocationData>? _locationSubscription;
  // Completer<GoogleMapController> _controller = Completer();
  // LocationData? _currentPosition;
  // LatLng? _latLong;
  bool _locating = false;
  // geocoding.Placemark? _placeMark;
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: busBackground,
      body: 
      Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: busBackground,

      )),
          // infoField(hintName: 'name', hintDecs: 'description'),
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80),topRight: Radius.circular(80)),
              color: busclay
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 320),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    AdminInfoField(
                      hint: 'please enter station name',
                      onChanged: (String value) {
                        _stationName = value;
                      },
                    ),
                    SizedBox(height: 20),
                              AdminInfoField(
                                hint: 'please enter station street',
                                onChanged: (String value) {
                                  _stationStr = value;
                                },
                              ),
                    SizedBox(height: 20),
                      AdminInfoField(
                        hint: 'please enter any nearby landmark',
                        onChanged: (String value) {
                          _statNearby = value;
                        },
                      ),
                    SizedBox(height: 20),
                      AdminInfoField(
                        hint: 'please enter station ID',
                        onChanged: (String value) {
                          _statID = value;
                        },
                      ),
                    SizedBox(height: 20),
                      ElevatedButton(
                        style: firstButton,
                            onPressed: () async {
                              final loc.LocationData _locationResult = await location.getLocation();
                              await FirebaseFirestore.instance
                                  .collection('station').doc(_statID)
                        
                                  .set(
                                    {
                                      'name': _stationName, 'street': _stationStr, 'nearby': _statNearby , 'latitude': _locationResult.latitude, 'longitude': _locationResult.longitude,
                                    }
                                  );
                                  Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => AdminHomePage()));
                        
                                  // .add({'name': _stationName, 'description': _stationDec});
                
                                  //  Navigator.of(context).push(MaterialPageRoute(
                                  //               builder: (context) => StationDetails()));
                            },
                            child: Text('Add new station', style: bText,))
                  ],
                ),
              ),
            ),
          ),
        ),
        
          
        ],
      ),
    );
  }
}

class AdminInfoField extends StatelessWidget {
  const AdminInfoField({
    Key? key, required this.onChanged, required this.hint,
  }) : super(key: key);
  final Function(String) onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
        // controller: textEdit,
        decoration:
            InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: busbottom, width: 1),
            )
            ),
        onChanged: onChanged
        );
  }
}

// class infoField extends StatelessWidget {
//   infoField({
//     Key? key,
//     required this.hintName,
//     required this.hintDecs,
//   }) : super(key: key);

//   final textEdit = TextEditingController();

//   late String _stationName, _stationDec;
//   final String hintName;
//   final String hintDecs;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//             // controller: textEdit,
//             decoration:
//                 InputDecoration(hintText: 'please enter station $hintName'),
//             onChanged: (String value) { 
//               _stationName = value;
//             }),
//         TextField(
//           // controller: textEdit,
//           decoration:
//               InputDecoration(hintText: 'please enter station $hintDecs'),
//           onChanged: (String value) {
//             _stationDec = value;
//           },
//         ),
//       ],
//     );
//   }
// }
