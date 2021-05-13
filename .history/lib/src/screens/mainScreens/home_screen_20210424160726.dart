import 'package:fahs/src/screens/profile/profile_screen.dart';
import 'package:fahs/src/screens/user/order/my_orders_screen.dart';
import 'package:fahs/src/screens/user/providers/provider_profile_screen.dart';
import 'package:fahs/src/widgets/custom_app_bar.dart';
import 'package:fahs/src/widgets/provider_item.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQuery.height * 0.2),
        child: CustomAppBar(
          title: 'الرئيسية',
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Card(
                
                              child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/log.png',
                  ),
                  radius: 45,
                ),
              ),
              Text(
                'أهلا بك',
              ),
              Text(
                'مركز الرياض للسيارات',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: mediaQuery.height * 0.05,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => MyOrdersScreen(),
                ),
              );
            },
            child: Container(
              height: mediaQuery.height * 0.2,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff20C3BA),
                    Color(0xff4CCA93),
                    Color(0xff5CCC85),
                    Color(0xff98D651),
                    Color(0xffA7D943),
                    Color(0xffCADF24),
                  ],
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'طلباتي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.height * 0.1,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => ProfileScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              height: mediaQuery.height * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Color(0xff20C3BA),
                  Color(0xff4CCA93),
                  Color(0xff5CCC85),
                  Color(0xff98D651),
                  Color(0xffA7D943),
                  Color(0xffCADF24),
                ], end: Alignment.bottomRight, begin: Alignment.topLeft),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icons/user (1).png'),
                      color: Colors.white,
                    ),
                    Text(
                      'حسابي',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
