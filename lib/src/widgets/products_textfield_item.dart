import 'package:flutter/material.dart';

class ProductsTextFieldItem extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool isDetails;
  final String hintText;
  final String initialValue;
  final Function(String) onChanged;
  ProductsTextFieldItem({
    @required this.label,
    @required this.hintText,
    @required this.onChanged,
    this.isDetails = false,
    this.initialValue,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.08,
      width: mediaQuery.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(9),
        color: Colors.black12,
      ),
      child: Center(
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Spacer(),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 8),
              // height: mediaQuery.height * 0.06,
              width: mediaQuery.width * 0.53,
              child: TextFormField(
                maxLines: isDetails ? 8 : 1,
                textDirection: TextDirection.rtl,
                style: TextStyle(),
                initialValue: initialValue,
                keyboardType: keyboardType,
                onChanged: onChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  hintText: hintText,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
