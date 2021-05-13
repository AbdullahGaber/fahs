import 'package:flutter/material.dart';

class ServiceConfirmationScreen extends StatefulWidget {
  @override
  _ServiceConfirmationScreenState createState() =>
      _ServiceConfirmationScreenState();
}

class _ServiceConfirmationScreenState extends State<ServiceConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('تأكيد الخدمة'),
        ),
      ),
      body: Directionality(textDirection:TextDirection.rtl,),
    );
  }
}
