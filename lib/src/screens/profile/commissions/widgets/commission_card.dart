import 'package:flutter/material.dart';

class CommissionsCard extends StatefulWidget {
  final String title;
  final String price;
  final bool waitingForConfirmation;
  final String createdAt;
  CommissionsCard({
    this.title,
    this.price,
    this.createdAt,
    this.waitingForConfirmation = false,
  });
  @override
  _CommissionsCardState createState() => _CommissionsCardState();
}

class _CommissionsCardState extends State<CommissionsCard> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
                side: BorderSide(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.createdAt.substring(0, 10),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                            // Icon(
                            //   Icons.delete_forever_rounded,
                            //   color: Colors.red,
                            //   size: 20,
                            // ),
                            //  Container(
                            //   height: 30,
                            //   width: 70,
                            //   decoration: BoxDecoration(
                            //     color: Theme.of(context).primaryColor,
                            //     borderRadius: BorderRadius.circular(20),
                            //   ),
                            //   child: Center(child: Text("عرض")),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'اجمالي :',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ),
                            Text(
                              widget.price,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xff20C3BA).withOpacity(0.8),
                              ),
                            ),
                            Text(
                              'ريال',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: mediaQuery.height * 0.05,
              right: mediaQuery.width * 0.4,
              child: Visibility(
                visible: widget.waitingForConfirmation,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  color: Colors.black26,
                  child: Text(
                    'بانتظار تأكيد الإدارة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
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
