import 'package:flutter/material.dart';

class TitleBarWidget extends StatelessWidget {
  final String title;
  TitleBarWidget({
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Color(0xffA4BE25).withOpacity(0.7),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
