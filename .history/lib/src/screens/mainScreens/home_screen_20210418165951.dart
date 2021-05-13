import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// dummy data
List<String> images = [
  'assets/images/temp1.jpg',
  'assets/images/temp2.jpg',
];
// .....
//

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(25),
              height: mediaQuery.height * 0.2,
              width: mediaQuery.width * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Carousel(
                  colo
                  dotColor: Color(0xfffecb00),
                  boxFit: BoxFit.fill,
                  borderRadius: true,
                  radius: Radius.circular(9),
                  images: images
                      .map((e) => Image.asset(
                            e,
                            fit: BoxFit.fill,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
