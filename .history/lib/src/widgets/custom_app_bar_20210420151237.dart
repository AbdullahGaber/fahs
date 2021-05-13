import 'package:flutter/material.dart';

class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(3/5,size.width/2,size.height*0.1.si);

    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 40);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
