import 'package:fahs/src/widgets/register_button.dart';
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
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$providerName',
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
                  Text('$orderId')
                ],
              )
            ],
          ),
        ),
        Positioned(
          // child: IconButton(
          //   icon: Icon(
          //     Icons.info,
          //     color: Colors.black,
          //   ),
          //   onPressed: onPressed,
          // ),
          child: RegisterButton(title: 'تفاصيل الطلب', onPressed: onPressed),
          top: mediaQuery.height * 0.0,
          left: mediaQuery.width * 0.001,
        )
      ],
    );
  }
}
