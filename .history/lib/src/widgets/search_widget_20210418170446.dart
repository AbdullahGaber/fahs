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
      child: Card(
        
        elevation: 7,
        child: Container(
          height: mediaQuery.height * 0.07,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            textInputAction: TextInputAction.search,
            onFieldSubmitted: onSubmitted,
            controller: controller,
            enabled: enabled,
            style: TextStyle(
              color: Colors.black,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              prefixIcon: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }
}
