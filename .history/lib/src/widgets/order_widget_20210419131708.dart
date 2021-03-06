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
    return Stack(
      alignment: Alignment.center,
      children: [
        ListTile(
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
                  Container(
                    padding: EdgeInsets.all(4),
                    height: mediaQuery.height * 0.03,
                    width: mediaQuery.width * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0xffA4BE25),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      Icons.call,
                      size: 15,
                    ),
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
                  Text('?????? ?????????? : $orderId')
                ],
              )
            ],
          ),
        ),
        // Positioned(
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.info_outline,
        //       color: Colors.black,
        //     ),
        //     onPressed: onPressed,
        //   ),
        //   top: mediaQuery.height * 0.0,
        //   left: mediaQuery.width * 0.003,
        // )
      ],
    );
  }
}
