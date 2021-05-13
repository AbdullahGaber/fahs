import 'package:fahs/src/widgets/custom_new_dialog.dart';
import 'package:fahs/src/widgets/order_widget.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/text_field_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final bool showRateButton;
  final bool activeOrder;
  OrderDetailsScreen({
    this.showRateButton = false,
    this.activeOrder = false,
  });
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String message = '';
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            
            Visibility(
              visible: widget.activeOrder,
              child: IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () async {
                  showModalBottomSheet<String>(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => StatefulBuilder(
                      builder: (ctx, setState) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFieldWidget(
                                  light: true,
                                  onChanged: (v) {
                                    setState(() {
                                      message = v;
                                    });
                                  },
                                  labelText: 'الشكوى',
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: mediaQuery.width * 0.3,
                                      child: RegisterButton(
                                        title: 'موافق',
                                        onPressed: message.isEmpty
                                            ? null
                                            : () async {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                var dialog = CustomDialog();
                                                await dialog.showOptionDialog(
                                                    context: context,
                                                    msg: 'هل ترغب بإرسال شكوى؟',
                                                    okFun: () async {
                                                      // await complaints.sendComplaint(
                                                      //   context,
                                                      //   complaint: message,
                                                      //   orderId: widget.product.id,
                                                      // );
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'تم ارسال الشكوى وسيتم مراجعتها من قبل الادارة');
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        message = '';
                                                      });
                                                    },
                                                    okMsg: 'نعم',
                                                    cancelFun: () {
                                                      setState(() {
                                                        message = '';
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      return;
                                                    },
                                                    cancelMsg: 'لا');
                                              },
                                        // color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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
                          subtitle: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('اسم العميل'),
                                  Text('طلب رقم 4545'),
                                ],
                              ),
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
                        Visibility(
                          visible: widget.showRateButton,
                          child: Container(
                            height: mediaQuery.height * 0.07,
                            child: RegisterButton(
                              title: 'تقييم مزود الخدمة',
                              onPressed: () {
                                CustomDialog().showOptionDialog(
                                  context: context,
                                  msg: 'سيتم إشعار العميل بذلك , هل أنت متأكد؟',
                                  cancelFun: () {
                                    return;
                                  },
                                  okFun: () {
                                    Fluttertoast.showToast(
                                        msg: 'تم الموافقة على الطلب');
                                    Navigator.of(context).pop();
                                  },
                                  okMsg: 'نعم',
                                  cancelMsg: 'لا',
                                );
                              },
                            ),
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
      ),
    );
  }
}
