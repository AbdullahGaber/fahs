import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationCard extends StatefulWidget {
  final String token;
  final model;
  final String title;
  final String message;

  final GestureTapCallback onTap;
  final GestureTapCallback click;
  final GestureTapCallback route;

  const NotificationCard({
    Key key,
    this.token,
    this.model,
    this.onTap,
    this.click,
    this.route,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.click,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Slidable(
          key: widget.key,
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: InkWell(
            onTap: widget.route,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border: Border.all(color: Colors.black.withOpacity(0.5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(widget.title,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            widget.message,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: widget.onTap,
              child: Material(
                shape: CircleBorder(),
                color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(Icons.delete, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
