import 'package:fahs/src/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

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
              width: mediaQuery.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Carousel(
                  dotIncreasedColor: Color(0xfffecb00),
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
          SearchWidget(
            hintText: 'البحث',
            suffixIcon: Icon(
              Icons.search,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 10,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'مزودين الخدمة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text(
              'مركز عبدالله',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: SmoothStarRating(
              rating: 5,
              isReadOnly: true,
              borderColor: Colors.black,
              size: 15,
              color: Color(0xff02A5E9),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
