import 'package:busproject/Register/register_styles.dart';
import 'package:busproject/screen/buses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class StationMap extends StatefulWidget {
  static const id = 'StationMap';

  const StationMap({Key? key}) : super(key: key);

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('About $stationLoc['name']'), backgroundColor: busblackBlue,),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('station')
              .doc()
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final stationLoc = (snapshot.data!.data() as Map<String, dynamic>);
            final Map<String, Marker> _markers = {};
            Future<void> _onMapCreated(GoogleMapController controller) async {
              _markers.clear();
              setState(() {
                final marker = Marker(
                  // icon: pinLocationIcon!,
                  markerId: MarkerId(stationLoc['name']),
                  position:
                      LatLng(stationLoc['latitude'], stationLoc['longitude']),

                );
                
                _markers[stationLoc['name']] = marker;
              });
            }

            return Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          stationLoc['latitude'], stationLoc['lnogitude']),
                      zoom: 70,
                    ),
                    markers: _markers.values.toSet(),
                  ),
                )
              ],
            );
          }),
    );
  }
}
