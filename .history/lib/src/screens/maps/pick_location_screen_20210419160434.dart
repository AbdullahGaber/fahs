import 'package:fahs/src/widgets/custom_new_dialog.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white60,
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
           ,
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(widget.isOrder ? 'تحديد الموقع' : 'تحديد العنوان')),
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
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
          Positioned(
            bottom: mediaQuery.height * 0.05,
            child: Visibility(
              visible: position != null,
              child: Container(
                height: mediaQuery.height * 0.07,
                child: RegisterButton(
                  onPressed: () {
                    CustomDialog().showOptionDialog(
                      msg: 'هل أنت متأكد من الموقع؟',
                      cancelFun: () {
                        return;
                      },
                      cancelMsg: 'لا',
                      context: context,
                      okFun: () {
                        Fluttertoast.showToast(
                            msg: 'تم إرسال الطلب وبانتظار تأكيد الإدارة');
                      },
                      okMsg: 'نعم',
                    );
                  },
                  title: 'اطلب الآن',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
