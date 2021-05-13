import 'package:custom_clippers/Clippers/directional_wave_clipper.dart';
import 'package:fahs/src/screens/auth/login_screen.dart';
import 'package:fahs/src/screens/auth/reset_password_screen.dart';
import 'package:fahs/src/widgets/custom_app_bar.dart';
import 'package:fahs/src/widgets/custom_new_dialog.dart';
import 'package:fahs/src/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(mediaQuery.height * 0.2),
                child: CustomAppBar(
                  title: 'حسابي',
                )),
          
          ),
          Positioned(
            top: mediaQuery.height * 0.18,
            child: Column(
              children: [
                Card(
                  shape: CircleBorder(),
                  elevation: 5,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/log.png'),
                  ),
                ),
                Text(
                  'اسم العميل',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            
          ),
        ],
      ),
    );
  }
}
