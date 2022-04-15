// // this page will be in comments //


// import 'package:busproject/screen/dummies_direction.dart';
// import 'package:flutter/material.dart';
// import 'package:busproject/stations/dummies.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:busproject/Register/register_styles.dart';
// import 'package:styled_text/styled_text.dart';

// class PlacesScreen extends StatefulWidget {
//   const PlacesScreen({Key? key}) : super(key: key);

//   static const id = 'Places_Screen';
//   @override
//   State<PlacesScreen> createState() => _PlacesScreenState();
// }

// class _PlacesScreenState extends State<PlacesScreen> {
//   Data data = Data();
//   Position? _currentUserPosition;
//   double? distanceImMeter = 0.0;

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

  // getDetails(dynamic singleStationData, BuildContext context) {
  //   // print(singleStationData);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => StationMap(
  //         stationData: singleStationData,
  //       ),
  //     ),
  //   );
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: busyellow,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: busblackBlue,
//         title: const Text("All Stations Nearbay",
//             style: const TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
//         child: ListView.builder(
          
//           itemCount: data.station.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 3),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(35),
//                     side: BorderSide(color: busblackBlue, width: 5)),
//                 elevation: 5,
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 380,
//                       width: 420,
//                       child: Image.network(
//                         data.station[index]['image'],
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: 420,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(
//                               data.station[index]['name'],
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const Icon(Icons.location_on, color: Colors.black),
//                           Text(
//                             "${data.station[index]['distance'].round()} KM Away",
//                             style: const TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Spacer(),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 10),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 primary: Color(0xffF9AE5D),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 side: BorderSide(
//                                     width: 2, color: Color(0xff03071E)),
//                               ),
//                               onPressed: () {
//                                 getDetails(data.station[index], context);
//                               },
//                               child: const Text("View Details"),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
