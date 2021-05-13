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
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.dollarSign,
                ),
                title: Text('مدفوعاتي',style: TextStyle(fontWeight: FontWeight.bold,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
