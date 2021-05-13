import 'package:fahs/src/screens/auth/login_screen.dart';
import 'package:fahs/src/widgets/custom_new_dialog.dart';
import 'package:fahs/src/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ,
              ),
              ProfileWidget(
                title: 'عمولاتي',
                icon: FontAwesomeIcons.dollarSign,
                onPressed: () {},
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
              ProfileWidget(
                title: 'تغيير كلمة المرور',
                imageIcon: 'assets/icons/password.png',
                icon: null,
                onPressed: () {},
              ),
              ListTile(
                onTap: () {
                  CustomDialog().showOptionDialog(
                    msg: 'هل ترغب بتسجيل الخروج',
                    cancelFun: () {
                      return;
                    },
                    okFun: () {
                      Fluttertoast.showToast(msg: 'تم تسجيل الخروج بنجاح');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (c) => LoginScreen(),
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
    );
  }
}
