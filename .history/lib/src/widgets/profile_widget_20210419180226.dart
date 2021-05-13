import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  final String imageIcon;
  ProfileWidget({
    @required this.title,
    @required this.icon,
    this.imageIcon,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        onTap: onPressed,
        leading: icon == null
            ? Transform.scale(
                scale: 0.5,
                child: ImageIcon(
                  AssetImage(
                    imageIcon,
                  ),
                  color: Colors.black,
                ),
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
