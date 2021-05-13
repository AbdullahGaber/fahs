import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white60,
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'الطلب من الداخل',
            )),
      ),
      body: Stack(
        alignment: Alignment.center,
      ),
    );
  }
}
