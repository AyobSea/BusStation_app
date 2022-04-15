// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:busproject/main.dart';

// class Firebase extends StatefulWidget {
//   @override
//   State<Firebase> createState() => _FirebaseState();
// }
    
// class _FirebaseState extends State<Firebase> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           children: [
//             StreamBuilder(
//                 stream:
//                     FirebaseFirestore.instance
//                     .collection('station')
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   return ListView(
//                       children: snapshot.data!.docs.map((grocery) {
//                     return Center(
//                       child: ListTile(
//                         title: Text(grocery['makkah']),
//                       ),
//                     );
//                   }).toList()
//                   );
//                 }
//                 ),
//           ],
//         ),
//         );
//   }
// }
