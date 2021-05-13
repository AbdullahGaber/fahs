import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final bool centerTitle;
  final bool showBackButton;
  final String title;
  CustomAppBar({
    @required this.title,
    this.centerTitle = false,
    this.showBackButton,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: SinCosineWaveClipper(
            horizontalPosition: HorizontalPosition.RIGHT,
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff20C3BA),
                Color(0xff4CCA93),
                Color(0xff5CCC85),
                Color(0xff98D651),
                Color(0xffA7D943),
                Color(0xffCADF24),
              ],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            )),
          ),
        ),
        ClipPath(
          clipper: SinCosineWaveClipper(
            horizontalPosition: HorizontalPosition.LEFT,
          ),
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ),
        ClipPath(
          clipper: DirectionalWaveClipper(
            horizontalPosition: HorizontalPosition.LEFT,
          ),
          child: Container(
            color: Color(0xff4CCA93).withOpacity(0.2),
          ),
        ),
        ClipPath(
          clipper: DirectionalWaveClipper(
            horizontalPosition: HorizontalPosition.RIGHT,
          ),
          child: Container(
            color: Color(0xffCADF24).withOpacity(0.2),
          ),
        ),

        // app bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            centerTitle: centerTitle,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
