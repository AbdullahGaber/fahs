import 'dart:ui';

import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.categoryName,
    @required this.imageUrl,
    @required this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final String categoryName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: Container(
        height: mediaQuery.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 5,
                left: 5,
                right: 5,
              ),
              height: mediaQuery.height * 0.22,
              width: mediaQuery.width * 0.38,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0xffA4BE25).withOpacity(0.4),
                  ],
                ),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                      height: mediaQuery.height * 0.15,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    categoryName,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              top: mediaQuery.height * 0.214,
              left: mediaQuery.height * 0.0,
              right: mediaQuery.height * 0.0,
              bottom: mediaQuery.height * 0.00,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: mediaQuery.height * 0.005,
                  width: mediaQuery.width * 0.05,
                  color: Color(0xffA4BE25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
