import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  final String orderTitle;
  final String providerName;
  final String price;
  final int orderId;
  final Function onPressed;
  OrderWidget({
    @required this.orderTitle,
    @required this.providerName,
    @required this.price,
    @required this.orderId,
    @required this.onPressed,
  });
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return ListTile(
      title: Text(
        '$orderTitle',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$providerName',
                ),
              ),
              Icon(
                Icons.call,
                color: Colors.white,
                size: 15,
              )
            ],
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
                    text: '$price',
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
              Text('رقم الطلب : $orderId')
            ],
          )
        ],
      ),
    );
  }
}
