import 'package:custom_clippers/Clippers/directional_wave_clipper.dart';
import 'package:fahs/src/screens/auth/login_screen.dart';
import 'package:fahs/src/screens/auth/reset_password_screen.dart';
import 'package:fahs/src/screens/chat/my_chat_screen.dart';
import 'package:fahs/src/screens/profile/commissions/commission_screen.dart';
import 'package:fahs/src/screens/profile/edit_profile_screen.dart';
import 'package:fahs/src/screens/profile/my_favorites_screen.dart';
import 'package:fahs/src/screens/tab_screen.dart';
import 'package:fahs/src/widgets/custom_app_bar.dart';
import 'package:fahs/src/widgets/custom_new_dialog.dart';
import 'package:fahs/src/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final int type;
  ProfileScreen({this.type});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<bool> onBackPress() async {
    if (widget.type == 0) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (c) => TabScreen(
              index: 1,
              type: 0,
            ),
          ),
          (route) => false);
    } else {
      Navigator.of(context).pop();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(mediaQuery.height * 0.2),
                  child: CustomAppBar(
                    title: 'حسابي',
                    actions: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            onBackPress();
                          })
                    ],
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
              top: mediaQuery.height * 0.35,
              left: 0,
              right: 0,
              bottom: 0,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileWidget(
                          title: 'تعديل البيانات',
                          icon: Icons.person,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => EditProfileScreen(),
                              ),
                            );
                          },
                        ),
                        Visibility(
                          visible: widget.type == 0,
                          child: ProfileWidget(
                            title: 'مفضلاتي',
                            icon: Icons.star,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (c) => MyFavoritesScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        ProfileWidget(
                          title: 'محادثاتي',
                          icon: Icons.message,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => MyChatScreen(),
                              ),
                            );
                          },
                        ),
                        Visibility(
                          visible: widget.type == 0,
                          child: ProfileWidget(
                            title: 'مدفوعاتي',
                            icon: FontAwesomeIcons.dollarSign,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (c) => CommissionsScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: widget.type == 1,
                          child: ProfileWidget(
                            title: 'قيمة الخدمة',
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
                        ),
                        ProfileWidget(
                          title: 'تواصل معنا',
                          icon: FontAwesomeIcons.mobileAlt,
                          onPressed: () {},
                        ),
                        ProfileWidget(
                          title: 'مشاركة التطبيق',
                          icon: Icons.share,
                          onPressed: () {},
                        ),
                        // ProfileWidget(
                        //   title: 'تغيير كلمة المرور',
                        //   imageIcon: 'assets/icons/password.png',
                        //   icon: null,
                        //   onPressed: () {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //         builder: (c) => ResetPasswordScreen(
                        //           isResetPassword: false,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                        ListTile(
                          onTap: () {
                            CustomDialog().showOptionDialog(
                              context: context,
                              msg: 'هل ترغب بتسجيل الخروج',
                              cancelFun: () {
                                return;
                              },
                              okFun: () {
                                Fluttertoast.showToast(
                                    msg: 'تم تسجيل الخروج بنجاح');
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (c) => LoginScreen(type: widget.type,),
                                    ),
                                    (route) => false);
                              },
                              okMsg: 'نعم',
                              cancelMsg: 'لا',
                            );
                          },
                          leading: ImageIcon(
                            AssetImage('assets/icons/logout.png'),
                            color: Color(0xff5FAE23),
                          ),
                          title: Text(
                            'تسجيل الخروج',
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
            ),
          ],
        ),
      ),
    );
  }
}
