import 'package:flutter/material.dart';

class SizeWidget extends StatelessWidget {
  final String title;
  final String label;
  final bool isDropDown;
  final List<String> items;
  final Function(String) onTap;

  SizeWidget({
    @required this.label,
    @required this.title,
    this.onTap,
    this.items,
    this.isDropDown = false,
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
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: !isDropDown
                  ? null
                  : () {
                      showModalBottomSheet<String>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: items
                                  .map((e) => InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop(e);
                                        },
                                        child: Center(
                                          child: Container(
                                            width: mediaQuery.width,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                // top: BorderSide(
                                                //   color: Theme.of(context).primaryColor,
                                                // ),
                                                bottom: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                            height: mediaQuery.height * 0.1,
                                            child: Center(
                                              child: Text(
                                                e,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ).then(onTap);
                    },
              child: Container(
                height: mediaQuery.height * 0.05,
                width: mediaQuery.width * 0.53,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  mainAxisAlignment: isDropDown
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    Text(title),
                    Visibility(
                      visible: isDropDown,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                // child: DropdownButton<String>(

                //     hint: Text(item),
                //     items: items
                //         .map(
                //           (e) => DropdownMenuItem<String>(
                //             child: Text(e),
                //             value: e,
                //           ),
                //         )
                //         .toList(),
                //     onChanged: (v) {
                //       setState(() {
                //         item = v;
                //       });
                //     }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
