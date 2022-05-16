import 'dart:async';
import 'package:busproject/adminside/admin_add_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:busproject/screen/home_screen.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminAddLocation extends StatefulWidget {
  static const id = 'adminAddLocation';
  const AdminAddLocation({ Key? key }) : super(key: key);

  @override
  State<AdminAddLocation> createState() => _AdminAddLocationState();
}

class _AdminAddLocationState extends State<AdminAddLocation> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  Completer<GoogleMapController> _controller = Completer();
  LocationData? _currentPosition;
  LatLng? _latLong;
  bool _locating = false;
  geocoding.Placemark? _placeMark;
  
  static const CameraPosition appStartLocation = CameraPosition(
    target: LatLng(35.6762, 139.6503),
    zoom: 11,
  );

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  Future<LocationData> _getLocationPermission() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Service not enabled');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Permission Denied');
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  _getUserLocation() async {
    _currentPosition = await _getLocationPermission();
    _goToCurrentPosition(
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!));
  }

  getUserAddress() async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(_latLong!.latitude, _latLong!.longitude);
    setState(() {
      _placeMark = placemarks.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .75,
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    /*border: Border(bottom: BorderSide(color: Colors.grey)),*/
                  ),
                  child: Stack(
                    children: [

                      GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        mapType: MapType.hybrid,
                        initialCameraPosition: appStartLocation,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMove: (CameraPosition position) {
                          setState(() {
                            _locating = true;
                            _latLong = position.target;
                          });
                        },
                        onCameraIdle: () {
                          setState(() {
                            _locating = false;
                          });
                          getUserAddress();
                        },
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.location_on,
                            size: 40,
                            color: Colors.red,
                          )
                          ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      _placeMark != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _locating
                                      ? 'Locating...'
                                      : _placeMark!.locality == null
                                          ? _placeMark!.subLocality!
                                          : _placeMark!.locality!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _placeMark!.subLocality!,
                                    ),
                                    Text(_placeMark!.subAdministrativeArea !=
                                            null
                                        ? '${_placeMark!.subAdministrativeArea!}, '
                                        : ''),
                                  ],
                                ),
                                Text(
                                    '${_placeMark!.administrativeArea!}, ${_placeMark!.country!}, ${_placeMark!.postalCode!}')
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1),
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints.tightFor(width: 180),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // _getLocation();

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddInfo()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    side: BorderSide(
                                        width: 2, color: Colors.white),
                                    minimumSize: Size.fromHeight(60),
                                  ),
                                  
                                  child: Text(
                                    'Select this location for a new station',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToCurrentPosition(LatLng latlng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(latlng.latitude, latlng.longitude),
        //tilt: 59.440717697143555,
        zoom: 14.4746)));
  }

  // _getLocation() async {
  //   try {
  //     final loc.LocationData _locationResult = await location.getLocation();
  //     await FirebaseFirestore.instance
  //         .collection('station')
          
  //         .add(
  //       {
  //         'latitude': _locationResult.latitude,
  //         'longitude': _locationResult.longitude,
          
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}