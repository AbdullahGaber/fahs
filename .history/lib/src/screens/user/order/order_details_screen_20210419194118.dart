import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  LatLng position;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white60,
        title: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              'الطلب من الداخل',
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: mediaQuery.height * 0.5,
            child: GoogleMap(
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
          ),
          Positioned(
            top: mediaQuery.height*0.5,
            child: Container(
            ),
          )
        ],
      ),
    );
  }
}
