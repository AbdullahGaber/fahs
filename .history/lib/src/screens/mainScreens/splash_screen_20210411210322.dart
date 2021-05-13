import 'dart:async';
import 'dart:io';

import 'package:cars_check_up/src/logic/providers/general/shared_preferences_provider.dart';
import 'package:cars_check_up/src/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:provider/provider.dart';
// import 'package:t3myrkm/src/screens/tab_screen.dart';
// import '../../../src/helper/firebaseNotifications.dart';
// import '../../screens/auth/login_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../logic/providers/general/shared_preferences_provider.dart';

class Splash extends StatefulWidget {
  final bool isLoggedIn;

  final GlobalKey<NavigatorState> navigator;
  final SharedPreferences prefs;
  const Splash({
    Key key,
    this.navigator,
    this.isLoggedIn = false,
    this.prefs,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool isInit = true;
  Future<Timer> _loadData() async {
    return Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (c)=>LoginScreen(),

          // builder: (ctx) => widget.isLoggedIn
          //     ? TabScreen(
          //         type: widget.prefs.get('type') == 'عميل' ? 0 : 1,
          //       )
          //     : LoginScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    _loadData();
    Future.delayed(Duration(microseconds: 1), () async {
      var data = Provider.of<SharedPreferencesProvider>(context, listen: false);
      await data.getInstance();
      // FirebaseDynamicLinks.instance
      //     .getDynamicLink(Uri.parse(Platform.isIOS
      //         ? 'https://t3myrkm.page.link/XktS'
      //         : 'https://t3myrkm.page.link/TG78'))
      //     .then((value) {
      //   print('done');
      //   if (value != null) {
      //     // data.prefs
      //     //     .setString(
      //     //       'shared_link',
      //     //       value.link.toString(),
      //     //     )
      //     //     .then((value) => print('li'));
      //   }
      // });
    });
    // FirebaseNotifications().setUpFirebase(widget.navigator, context);

    super.initState();
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _globalKey,
        body: Stack(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/icon004.png',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .8),
                child: Shimmer.fromColors(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "مرحبا بكم في تطبيق فحص السيارات",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff20C3BA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  baseColor: Color(0xff20C3BA),
                  highlightColor: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
