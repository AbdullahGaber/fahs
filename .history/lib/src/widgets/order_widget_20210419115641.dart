import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
                    title: Text(
                      'عنوان مختصر للطلب',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'اسم مزود الخدمة',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'SR ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: '5451151',
                                  style: TextStyle(
                                    color: Color(0xff1FB7F1),
                                    fontSize: 15,
                                  ),
                                ),
                              ]),
                            ),
                            // Text(
                            //   'SR 2151215',
                            // ),
                            Text('رقم الطلب')
                          ],
                        )
                      ],
                    ),
                  );
  }
}