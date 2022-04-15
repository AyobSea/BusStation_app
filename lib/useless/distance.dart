// import 'package:busproject/screen/dummies_detail.dart';
// import 'package:busproject/stations/dummies.dart';
// import 'package:busproject/stations/map.dart';
// import 'package:busproject/Register/register_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class Distance extends StatefulWidget {
//   const Distance({Key? key}) : super(key: key);

//   @override
//   _DistanceState createState() => _DistanceState();
// }

// class _DistanceState extends State<Distance> {
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
//     return Scaffold(
//       extendBody: true,
//       backgroundColor: Color(0xffA8AABC),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: busblackBlue,
//         title: const Text("All Stations Near your location",
//             style: const TextStyle(color: Colors.white)),
//       ),
//       body: GridView.builder(
//           itemCount: data.station.length,
//           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 1000,
//             childAspectRatio: 1.7,
//             crossAxisSpacing: 1,
//             mainAxisSpacing: 5,
//           ),
//           itemBuilder: (context, index) {
//             return Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 3,
//                   color: Colors.white,
//                 ),
//               ),
//               height: 5,
//               width: 5,
//               child: Column(
//                 children: [
//                   Container(
//                     height: 160,
//                     width: 420,
//                     child: Image.network(
//                       data.station[index]['image'],
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         data.station[index]['name'],
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
                      
//                       const Icon(Icons.location_on, color: Colors.white),
//                       Text(
//                         "${data.station[index]['distance'].round()} KM Away",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(width: 25),
//                       ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.green,side: BorderSide(width: 1, color: Colors.red,)), onPressed: null, child: Text('take this',style: TextStyle(color: Colors.white),))
//                     ],
//                   ),
                  
//                 ],
//               ),
//             );
//           }),
//       floatingActionButton: Padding(
//             padding: const EdgeInsets.only(bottom: 70.0),
//         child: FloatingActionButton(child: Icon(Icons.map), onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => PlacesScreen()));
//         }),
//       ),
//     );
//   }
// }
