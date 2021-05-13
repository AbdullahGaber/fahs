import 'package:flutter/material.dart';
import '../../../widgets/text_field_widget.dart';

class SendWidget extends StatelessWidget {
  final TextEditingController controller;
  final String message;
  final Function(String) onChanged;
  final Function sendMessage;
  final Function onSendFile;
  SendWidget({
    @required this.message,
    @required this.controller,
    @required this.onChanged,
    @required this.sendMessage,
    @required this.onSendFile,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height * 0.1,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: Colors.black,
          ))),
      child: Row(
        children: [
          Expanded(
            child: TextFieldWidget(
              controller: controller,
              onChanged: onChanged,
              isDetails: true,
              labelText: 'اكتب رسالتك',
              light: true,
            ),
          ),
          // IconButton(
          //     icon: Icon(
          //       Icons.add_a_photo,
          //       color: Color(0xffA4BE25),
          //     ),
          //     onPressed: sendMessage),
          // IconButton(
          //     iconSize: 30,
          //     icon: Icon(
          //       Icons.add_a_photo,
          //       color: Colors.grey,
          //     ),
          //     onPressed: onSendFile),
          Card(
            elevation: 8,
            shape: CircleBorder(),
            color: Theme.of(context).primaryColor,
            child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: message.isEmpty ? Colors.white70 : Color(0xffA4BE25),
                ),
                onPressed: sendMessage),
          ),
        ],
      ),
    );
  }
}
