import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/register_button.dart';

class ServiceConfirmationScreen extends StatefulWidget {
  final String bankName;
  final String accountNumber;
  final String carModel;
  final String carMark;

  final File paymentImage;
  ServiceConfirmationScreen({
    @required this.bankName,
    @required this.bankName,
  });
  @override
  _ServiceConfirmationScreenState createState() =>
      _ServiceConfirmationScreenState();
}

class _ServiceConfirmationScreenState extends State<ServiceConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('تأكيد الخدمة'),
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
                          title: 'تأكيد الخدمة',
                          onPressed: () {
                            CustomDialog().showOptionDialog(
                              context: context,
                              msg: 'سيتم إرسال الطلب , هل أنت متأكد؟',
                              cancelFun: () {
                                return;
                              },
                              okFun: () {
                                Fluttertoast.showToast(
                                    msg:
                                        'تم ارسال الطلب, وجاري مراجعته من قبل الادارة');
                                Navigator.of(context).pop();
                              },
                              okMsg: 'نعم',
                              cancelMsg: 'لا',
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
