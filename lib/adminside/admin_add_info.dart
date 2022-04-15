import 'package:busproject/screen/station_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final _auth = FirebaseAuth.instance;
  late String _stationName, _stationDec;
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
      body: Column(
        children: [
          // infoField(hintName: 'name', hintDecs: 'description'),
                  TextField(
            // controller: textEdit,
            decoration:
                InputDecoration(hintText: 'please enter station'),
            onChanged: (String value) { 
              _stationName = value;
            }),
        TextField(
          // controller: textEdit,
          decoration:
              InputDecoration(hintText: 'please enter station'),
          onChanged: (String value) {
            _stationDec = value;
          },
        ),
          ElevatedButton(
              onPressed: () async {
                final loc.LocationData _locationResult = await location.getLocation();
                await FirebaseFirestore.instance
                    .collection('station')
                    
                    .add(
                      {
                        'name': _stationName, 'description': _stationDec, 'latitude': _locationResult.latitude, 'longitude': _locationResult.longitude,
                      }
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StationDetails()));
                    
                    // .add({'name': _stationName, 'description': _stationDec});

                    //  Navigator.of(context).push(MaterialPageRoute(
                    //               builder: (context) => StationDetails()));
              },
              child: Text('press'))
        ],
      ),
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
