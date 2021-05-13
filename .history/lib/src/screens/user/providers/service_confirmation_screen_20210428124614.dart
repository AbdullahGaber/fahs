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
    @required this.accountNumber,
    @required this.carModel,
    @required this.carMark,
    @required this.paymentImage,
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 0,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 4),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'بيانات السيارة',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 7,
                              ),
                              child: Column(
                                children: [
                                  Text('${widget.carMark}  ${widget.carModel}'),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'بيانات الدفع',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 7,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'اسم البنك  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.bankName,
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'رقم الحساب  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.accountNumber,
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'صورة الدفع',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: mediaQuery.width * 0.8,
                                    height: mediaQuery.height * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      image: DecorationImage(
                                        image: FileImage(widget.paymentImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                Navigator.of(context).pushAndRemoveUntil(MaterialPAge);
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
