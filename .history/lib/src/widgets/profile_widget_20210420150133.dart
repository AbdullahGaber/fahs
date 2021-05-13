import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  final Widget trailing;
  final String imageIcon;
  ProfileWidget({
    @required this.title,
    @required this.icon,
    this.imageIcon,
    this.trailing,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        onTap: onPressed,
        leading: icon == null
            ? ImageIcon(
                AssetImage(
                  imageIcon,
                ),
                color: Colors.black,
              )
            : Icon(
                icon,
              ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailing ??
            CircleAvatar(
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
