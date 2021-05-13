import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final Function(String) onChanged;
  final String labelText;
  final String hintText;
  final String initialValue;
  final bool secureText;
  final bool isDetails;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final bool enableText;
  final bool light;
  TextFieldWidget({
    @required this.onChanged,
    this.labelText,
    this.initialValue,
    this.keyboardType,
    this.secureText = false,
    this.suffixIcon,
    this.enableText = true,
    this.hintText,
    this.isDetails = false,
    this.light = false,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 25, vertical: isDetails ? 1 : 5),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          child: Container(
            height: isDetails ? null : mediaQuery.height * 0.07,
            width: mediaQuery.width * 0.8,
            child: TextFormField(
              maxLines: isDetails ? 8 : 1,
              initialValue: controller != null ? null : initialValue,
              controller: initialValue != null ? null : controller,
              enabled: enableText,
              keyboardType: keyboardType,
              style: TextStyle(
                color: light ? Theme.of(context).primaryColor : Colors.black,
              ),
              obscureText: secureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                labelText: labelText,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: light ? Theme.of(context).primaryColor : Colors.black,
                  fontSize: 12,
                ),
                labelStyle: TextStyle(
                  color: light ? Theme.of(context).primaryColor : Colors.black,
                ),
                fillColor: Colors.white.withOpacity(0.08),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: BorderSide(
                    color: light
                        ? Theme.of(context).primaryColor
                        : Colors.white.withOpacity(0.3),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: BorderSide(
                    color: light
                        ? Theme.of(context).primaryColor
                        : Colors.white.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: BorderSide(
                    color: light
                        ? Theme.of(context).primaryColor
                        : Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
