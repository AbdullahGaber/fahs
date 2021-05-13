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
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Carousel(images: images.map((e) => Image.asset(e,)),
            ),
          ),
        ],
      ),
    );
  }
}
