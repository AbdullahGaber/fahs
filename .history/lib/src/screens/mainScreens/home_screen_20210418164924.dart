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
          Container(
            // height: mediaQuery.height * 0.1,
            // width: mediaQuery.width * 0.1,
            child: Expanded(
              child: Carousel(
                images: images
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Image.asset(
                            e,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
