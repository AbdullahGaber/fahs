import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsItem extends StatelessWidget {
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
      on
    );
  }
}
