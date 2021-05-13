import 'package:flutter/material.dart';
import './widgets/google_map_item.dart';

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
