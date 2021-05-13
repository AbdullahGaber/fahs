import 'package:fahs/src/widgets/custom_new_dialog.dart';
import 'package:flutter/material.dart';
import './widgets/google_map_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  final bool isOrder;
  PickLocationScreen({this.isOrder = false});

  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  LatLng position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.isOrder
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.check,
                ),
                onPressed: position == null
                    ? null
                    : () {
                        CustomDialog().showOptionDialog(
                          msg: 'هل أنت متأكد؟',
                          cancelFun: () {
                            return;
                          },
                          cancelMsg: 'لا',
                          context: context,
                          okFun: () {
                            Navigator.of(context).pop();
                          },
                          okMsg: 'نعم',
                        );
                      },
              ),
        title: Align(
            alignment: Alignment.centerRight, child: Text('تحديد العنوان')),
        actions: widget.isOrder
            ? null
            : [
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
      ),
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
