import 'package:fahs/src/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
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
            children: [
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
                icon: ImageIcon,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
