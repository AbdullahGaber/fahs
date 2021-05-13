import 'package:flutter/material.dart';

class ConversationsWidget extends StatelessWidget {
  final String userName;
  final String imageUrl;
  final String lastMessage;
  final Function onTap;

  const ConversationsWidget({
    @required this.userName,
    @required this.imageUrl,
    @required this.lastMessage,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: mediaQuery.width,
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 5,
        ),
        // decoration: BoxDecoration(
        // color: Colors.black12,
        //   border: Border.all(

        //   ),
        // ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          trailing: CircleAvatar(
            backgroundImage: AssetImage(
              imageUrl,
            ),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              userName.trim(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.b,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Align(
            alignment: Alignment.centerRight,
            child: Text(
              lastMessage.trim(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.b,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
