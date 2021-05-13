import 'package:flutter/material.dart';

class OrderTextFieldItem extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String) onChanged;
  OrderTextFieldItem({
    @required this.title,
    @required this.hintText,
    @required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: mediaQuery.height * 0.08,
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 25,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 25,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(
                0.3,
              ),
            ),
            // color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              bottomLeft: Radius.circular(9),
              topRight: Radius.circular(9),
              bottomRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Container(
                // height: mediaQuery.height * 0.04,
                width: mediaQuery.width * 0.4,
                // padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextFormField(
                  maxLines: 8,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: mediaQuery.width * 0.066,
          child: Container(
            width: mediaQuery.width * 0.006,
            height: mediaQuery.height * 0.03,
            color: Color(0xffA4BE25),
          ),
        ),
      ],
    );
  }
}
