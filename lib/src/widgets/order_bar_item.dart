import 'package:flutter/material.dart';
import './custom_new_dialog.dart';

class OrderBarItem extends StatelessWidget {
  final String title;
  final String number;
  OrderBarItem({
    @required this.title,
    @required this.number,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: mediaQuery.height * 0.08,
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 25,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 25,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(
                0.3,
              ),
            ),
            // color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              bottomLeft: Radius.circular(9),
              topRight: Radius.circular(9),
              bottomRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 15,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: title.contains('مكان التوصيل')
                    ? () async {
                        await CustomDialog().showWarningDialog(
                          context: context,
                          btnOnPress: () {},
                          msg: number,
                        );
                      }
                    : null,
                child: Container(
                  height: mediaQuery.height * 0.04,
                  width: mediaQuery.width * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  child: Center(
                    child: Text(number,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            // color: Colors.white,
                            )),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: mediaQuery.width * 0.066,
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
