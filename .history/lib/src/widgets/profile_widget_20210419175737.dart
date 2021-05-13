import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
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
        onTap: onPressed,
        leading: Icon(
          icon,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child:icon Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
