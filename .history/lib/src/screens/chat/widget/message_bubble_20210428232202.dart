import 'package:flutter/material.dart';
import './image_view_screen.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String imageUrl;
  final bool isMe;
  final bool seen;
  final String userImage;
  final String createdAt;
  final String userName;
  final bool isImage;

  MessageBubble({
    @required this.message,
    @required this.isMe,
    @required this.seen,
    @required this.userImage,
    @required this.userName,
    @required this.createdAt,
    @required this.imageUrl,
    @required this.isImage,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Stack(
      // alignment: Alignment.centerRight,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? Color(0xffDBF9C5) : Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isImage
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) => ImageViewScreen(
                                senderName: isMe ? 'أنت' : userName,
                                imageUrl: imageUrl,
                                dateTime: createdAt.substring(0, 16),
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: imageUrl,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        message,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      createdAt.substring(0, 10),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
                      ),
                    ),
                    Spacer(),
                    Text(
                      createdAt.substring(10, 16),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            )),
        Positioned(
          right: isMe ? mediaQuery.width * 0.02 : null,
          left: !isMe ? mediaQuery.width * 0.02 : null,
          top: mediaQuery.width * -0.01,
          child: CircleAvatar(
            backgroundImage: AssetImage(
              userImage,
            ),
            radius: 20,
          ),
        ),
        Positioned(
          left: isMe ? mediaQuery.width * 0.08 : null,
          right: !isMe ? mediaQuery.width * 0.08 : null,
          bottom: mediaQuery.width * 0.03,
          child: Visibility(
            visible: isMe && seen,
            child: Icon(
              Icons.check,
              color: Colors.blue,
              size: 15,
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
