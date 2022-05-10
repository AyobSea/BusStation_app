import 'package:busproject/useless/dummies.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleCity extends StatefulWidget {
  final Map cityData;
  const SingleCity({Key? key, required this.cityData}) : super(key: key);

  @override
  State<SingleCity> createState() => _SingleCityState();
}

class _SingleCityState extends State<SingleCity> {

  // BitmapDescriptor? pinLocationIcon;

  // void setCustomMapPin() async {
  //   pinLocationIcon = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(devicePixelRatio: 2.5),
  //     'assets/images/markericon.png',
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setCustomMapPin();
  }

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      final marker = Marker(
        // icon: pinLocationIcon!,
        markerId: MarkerId(widget.cityData['name']),
        position: LatLng(widget.cityData['lat'], widget.cityData['lng']),
        infoWindow: InfoWindow(
            title: widget.cityData['name'],
            snippet: widget.cityData['address'],
            onTap: () {
              print("${widget.cityData['lat']}, ${widget.cityData['lng']}");
            }),
        onTap: () {
          print("Clicked on marker");
        },
      );
      print("${widget.cityData['lat']}, ${widget.cityData['lng']}");
      _markers[widget.cityData['name']] = marker;
    });
  }

  Data data = Data();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('About ${widget.cityData['name']}')),
      body: Column(
        children: [
         
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.cityData['lat'], widget.cityData['lng']),
                zoom: 17,
              ),
              markers: _markers.values.toSet(),
            ),
          )
        ],
      ),
    );
  }
}

