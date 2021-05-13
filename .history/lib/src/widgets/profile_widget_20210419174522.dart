import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final IconDatacon;
  final Function onPressed;
  ProfileWidget({
    @required this.title,
    @required this.icon,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.dollarSign,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
