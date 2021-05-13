import 'package:fahs/src/widgets/custom_new_dialog.dart';
import 'package:fahs/src/widgets/order_widget.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: mediaQuery.height * 0.5,
              child: Container(
                height: mediaQuery.height * 0.5,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      31.0531005,
                      31.380355,
                    ),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(
                        DateTime.now().toString(),
                      ),
                      position: LatLng(
                        31.05303422825079,
                        31.379823423922062,
                      ),
                    ),
                  },
                  onTap: null,
                ),
              ),
            ),
            Positioned(
              top: mediaQuery.height * 0.48,
              bottom: 0,
              right: 0,
              left: 0,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 9,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // OrderWidget(
                      //   orderTitle: 'عنوان مختصر للطلب',
                      //   providerName: 'اسم المزود',
                      //   price: '154',
                      //   orderId: 52,
                      //   onPressed: () {},
                      // ),
                      ListTile(
                        title: Text(
                          'عنوان مختصر للطلب',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('اسم العميل'),
                            Text('طلب رقم 4545'),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'سيارة تويوتا  ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'كامري 2020',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'SR ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '653',
                                    style: TextStyle(
                                      color: Color(0xff1FB7F1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'تفاصيل الطلب',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'محتوى تجريبي يتم استبداله فيما بعد بمحتوى تفاصيل الطلب الحقيقية محتوى تجريبي يتم استبداله فيما بعد بمحتوى تفاصيل الطلب الحقيقية محتوى تجريبي يتم استبداله فيما بعد بمحتوى تفاصيل الطلب الحقيقية',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.05,
                      ),
                      Container(
                        height: mediaQuery.height * 0.07,
                        child: RegisterButton(
                          title: 'أوافق على الطلب',
                          onPressed: () {
                            CustomDialog().showOptionDialog(
                              msg: 'سيتم إشعار العميل بذلك , هل أنت متأكد؟',
                              
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
