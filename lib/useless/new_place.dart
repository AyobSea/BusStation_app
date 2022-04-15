// // Calculate distance in this page



// import 'package:busproject/stations/dummies.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:busproject/stations/dummies.dart';

// class Calc extends StatefulWidget {
//   @override
//   State<Calc> createState() => _CalcState();
// }

// class _CalcState extends State<Calc> {
//   Position? _currentUserPosition;
//   double? distanceImMeter = 0.0;
//   Data data = Data();

//   Future _getTheDistance() async {
//     _currentUserPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     for (int i = 0; i < data.station.length; i++) {
//       double storelat = data.station[i]['lat'];
//       double storelng = data.station[i]['lng'];

//       distanceImMeter = await Geolocator.distanceBetween(
//         _currentUserPosition!.latitude,
//         _currentUserPosition!.longitude,
//         storelat,
//         storelng,
//       );
//       var distance = distanceImMeter?.round().toInt();

//       data.station[i]['distance'] = (distance! / 800);
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     _getTheDistance();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
