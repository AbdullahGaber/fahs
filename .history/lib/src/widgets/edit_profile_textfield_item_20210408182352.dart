import 'package:flutter/material.dart';

class EditProfileTextFieldItem extends StatelessWidget {
  final String initialValue;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hintText;
  final Function onPressed;
  final bool enablEditing;
  final bool hidePassword;
  final Function(String) onChanged;
  final String labelText;
  final Widget icon;

  EditProfileTextFieldItem({
    this.initialValue,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.icon,
    this.labelText,
    this.onPressed,
    this.enablEditing = true,
    this.hidePassword = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        enabled: enablEditing,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: initialValue != null ? null : controller,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          suffixIcon: icon,
        ),
        obscureText: hidePassword,
      ),
    );
  }
}
