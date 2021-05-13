import 'package:flutter/material.dart';

class ProductBarWidget extends StatelessWidget {
  final String productName;
  final int productPrice;
  ProductBarWidget({
    @required this.productName,
    @required this.productPrice,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 25),
      color: Color(0xff1E2336),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            'SR ${productPrice.toStringAsFixed(2)}',
            style: TextStyle(
              color: Color(0xffA4BE25),
            ),
          ),
        ],
      ),
    );
  }
}
