import 'package:custom_clippers/Clippers/directional_wave_clipper.dart';
import 'package:fahs/src/screens/auth/login_screen.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: SinCosineWaveClipper(
                horizontalPosition: HorizontalPosition.RIGHT,
              ),
              child: Container(
             decoration: BoxDecoration(
          gradient: (color == null && !showBorder)
              ? LinearGradient(
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
                )
              : null,
          color: color ?? null,
          borderRadius: BorderRadius.circular(9),
          border: !showBorder
              ? null
              : Border.all(
                  color: Colors.white,
                  width: 3,
                ),
        ),
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
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/images/log.png'),
                        ),
                        Text(
                          '?????? ????????????',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ProfileWidget(
                  title: '??????????????',
                  icon: FontAwesomeIcons.dollarSign,
                  onPressed: () {},
                ),
                ProfileWidget(
                  title: '???????? ????????????',
                  icon: FontAwesomeIcons.dollarSign,
                  trailing: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'SR ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: '4554',
                        style: TextStyle(
                          color: Color(0xff1FB7F1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  onPressed: () {},
                ),
                ProfileWidget(
                  title: '?????????? ????????',
                  icon: FontAwesomeIcons.mobileAlt,
                  onPressed: () {},
                ),
                ProfileWidget(
                  title: '???????????? ??????????????',
                  icon: Icons.share,
                  onPressed: () {},
                ),
                ProfileWidget(
                  title: '?????????? ???????? ????????????',
                  imageIcon: 'assets/icons/password.png',
                  icon: null,
                  onPressed: () {},
                ),
                ListTile(
                  onTap: () {
                    CustomDialog().showOptionDialog(
                      msg: '???? ???????? ???????????? ????????????',
                      cancelFun: () {
                        return;
                      },
                      okFun: () {
                        Fluttertoast.showToast(msg: '???? ?????????? ???????????? ??????????');
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (c) => LoginScreen(),
                            ),
                            (route) => false);
                      },
                      okMsg: '??????',
                      cancelMsg: '????',
                    );
                  },
                  leading: ImageIcon(
                    AssetImage('assets/icons/logout.png'),
                    color: Color(0xff5FAE23),
                  ),
                  title: Text(
                    '?????????? ????????????',
                    style: TextStyle(
                      color: Color(0xff5FAE23),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
