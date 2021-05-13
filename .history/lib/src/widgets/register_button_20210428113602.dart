import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final double width;
  final String title;
  final Color color;
  final bool isActiveColor;
  final Color textColor;
  final Function onPressed;
  final bool showBorder;
  RegisterButton({
    this.width,
    @required this.title,
    this.color,
    this.textColor,
    this.isActiveColor=true,
    this.showBorder = false,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 5,
      ),
      width: width == null ? mediaQuery.width * 0.8 : mediaQuery.width * width,
      child: Container(
        decoration: BoxDecoration(
          gradient: (color == null && !showBorder&&isActiveColor)
              ? LinearGradient(
                  colors: [
                    Color(0xff20C3BA),
                    Color(0xff4CCA93),
                    Color(0xff5CCC85),
                    Color(0xff98D651),
                    Color(0xffA7D943),
                    Color(0xffCADF24),
                  ],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight,
                )
              : null,
          color:!isActiveColor? Colors.bla:color ?? null,
          borderRadius: BorderRadius.circular(9),
          border: !showBorder
              ? null
              : Border.all(
                  color: Colors.white,
                  width: 3,
                ),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: textColor == null ? Colors.white : textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
