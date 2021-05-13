import 'package:fahs/src/logic/providers/general/notifications/notifications_provider.dart';
import 'package:fahs/src/screens/Notifications/notificationPage.dart';
import 'package:fahs/src/screens/profile/profile_screen.dart';
import 'package:fahs/src/screens/user/order/my_orders_screen.dart';
import 'package:fahs/src/screens/user/providers/provider_profile_screen.dart';
import 'package:fahs/src/widgets/custom_app_bar.dart';
import 'package:fahs/src/widgets/provider_item.dart';
import 'package:fahs/src/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class HomeScreen extends StatefulWidget {
  final int type;
  HomeScreen({
    @required this.type,
  });
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
  String filterBy = 'الأقرب';
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return widget.type == 0
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text('الرئيسية'),
                ),
                actions: [
                  PopupMenuButton(
                    icon: Icon(FontAwesomeIcons.filter),
                    itemBuilder: (c) => [
                      CheckedPopupMenuItem(
                        checked: ,
                      ),
                      CheckedPopupMenuItem(),
                      CheckedPopupMenuItem(),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: ImageIcon(
                          AssetImage(
                            'assets/icons/notification.png',
                          ),
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => NotificationPage(),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: mediaQuery.height * 0.01,
                        right: mediaQuery.width * 0.03,
                        child: Consumer<NotificationsProvider>(
                          builder: (_, snap, __) => Visibility(
                            visible: snap.unReadNotification != 0,
                            child: CircleAvatar(
                              radius: 10,
                              child: Text(
                                '${snap.unReadNotification}',
                                style: TextStyle(fontSize: 13),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (ctx, i) => ProviderItem(
                          providerDistance: 1.5,
                          providerImage: 'assets/images/log.png',
                          providerName: 'مركز تجربة',
                          providerRate: 4.5,
                          serviceCost: '45215',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => ProviderProfileScreen(),
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(mediaQuery.height * 0.2),
                    child: CustomAppBar(
                      title: 'الرئيسية',
                      actions: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            IconButton(
                              icon: ImageIcon(
                                AssetImage(
                                  'assets/icons/notification.png',
                                ),
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => NotificationPage(),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: mediaQuery.height * 0.01,
                              right: mediaQuery.width * 0.03,
                              child: Consumer<NotificationsProvider>(
                                builder: (_, snap, __) => Visibility(
                                  visible: snap.unReadNotification != 0,
                                  child: CircleAvatar(
                                    radius: 10,
                                    child: Text(
                                      '${snap.unReadNotification}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mediaQuery.height * 0.05,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) => MyOrdersScreen(
                                type: widget.type,
                              ),
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
                              builder: (c) => ProfileScreen(
                                type: widget.type,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: mediaQuery.height * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xff20C3BA),
                                  Color(0xff4CCA93),
                                  Color(0xff5CCC85),
                                  Color(0xff98D651),
                                  Color(0xffA7D943),
                                  Color(0xffCADF24),
                                ],
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft),
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
                ),
                Positioned(
                  top: mediaQuery.height * 0.18,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 5,
                        shape: CircleBorder(),
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
                ),
              ],
            ),
          );
  }
}
