import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileWidget extends StatefulWidget {
  final String title;
  final Widget icon;
  
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.dollarSign,
        ),
        title: Text(
          'مدفوعاتي',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
