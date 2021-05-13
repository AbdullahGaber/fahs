import 'package:flutter/material.dart';
import './widgets/google_map_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  LatLng position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(t),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            31.0531005,
            31.380355,
          ),
          zoom: 15,
        ),
        markers: position == null
            ? null
            : {
                Marker(
                  markerId: MarkerId(
                    position.latitude.toString(),
                  ),
                  position: position,
                ),
              },
        onTap: (place) {
          setState(() {
            position = place;
          });
        },
      ),
    );
  }
}
