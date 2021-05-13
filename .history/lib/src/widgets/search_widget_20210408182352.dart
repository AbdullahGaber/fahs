import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final Widget suffixIcon;
  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  SearchWidget({
    this.onChanged,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.onSubmitted,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: mediaQuery.height * 0.07,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        color: Color(0xff2E4499),
        child: TextFormField(
          textInputAction: TextInputAction.search,
          onFieldSubmitted: onSubmitted,
          controller: controller,
          enabled: enabled,
          style: TextStyle(
            color: Colors.white,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 15,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
