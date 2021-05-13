import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsItem extends StatefulWidget {
  @override
  _GoogleMapsItemState createState() => _GoogleMapsItemState();
}

class _GoogleMapsItemState extends State<GoogleMapsItem> {
  LatLng position;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          31.0531005,
          31.380355,
        ),
        zoom: 15,
      ),
      onTap: (place) {
        setState(() {
          position = place;
        });
      },
    );
  }
}
