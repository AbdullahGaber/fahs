import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int quantity;
  final Function increment;
  final Function decrement;
  CounterWidget({
    @required this.quantity,
    @required this.increment,
    @required this.decrement,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.08,
      width: mediaQuery.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(9),
        color: Colors.black12,
      ),
      child: Center(
        child: Row(
          children: [
            Text(
              'العدد',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Spacer(),
            Container(
              height: mediaQuery.height * 0.05,
              width: mediaQuery.width * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: increment,
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
            SizedBox(
              width: mediaQuery.width * 0.015,
            ),
            Container(
              height: mediaQuery.height * 0.05,
              width: mediaQuery.width * 0.34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Center(
                child: Text('$quantity'),
              ),
            ),
            SizedBox(
              width: mediaQuery.width * 0.015,
            ),
            Container(
              height: mediaQuery.height * 0.05,
              width: mediaQuery.width * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: decrement,
                child: Icon(
                  Icons.remove,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
