import 'package:flutter/material.dart';

class SettingsButtonWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final Widget icon;
  SettingsButtonWidget({
    @required this.title,
    @required this.onTap,
    @required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 20,
            left: 15,
            top: 5,
            bottom: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(9),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            onTap: onTap,
            title: Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: Container(
                padding: EdgeInsets.all(4),
                height: mediaQuery.height * 0.05,
                width: mediaQuery.width * 0.08,
                decoration: BoxDecoration(
                  color: Color(0xffA4BE25),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: icon),
          ),
        ),
        Positioned(
          right: mediaQuery.width * 0.056,
          child: Container(
            width: mediaQuery.width * 0.006,
            height: mediaQuery.height * 0.03,
            color: Color(0xffA4BE25),
          ),
        ),
      ],
    );
  }
}
