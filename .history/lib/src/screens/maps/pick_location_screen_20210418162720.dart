import 'package:flutter/material.dart';
import './widgets/google_map_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMapsItem(),
    );
  }
}
