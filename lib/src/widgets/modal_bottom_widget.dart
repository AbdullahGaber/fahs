import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/image_picker_dialog.dart';
import '../logic/models/chat/chat_message_model.dart';
import '../logic/providers/chat/my_conversations_provider.dart';
import '../logic/providers/general/shared_preferences_provider.dart';
import '../screens/chat/socket.io/socket_utils.dart';
import '../widgets/register_button.dart';

class ModalBottomWidget {
  static showModalBottomWidget({
    Size mediaQuery,
    BuildContext context,
    List<String> items,
    Function(String) onTap,
  }) {
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
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          height: mediaQuery.height * 0.1,
                          child: Center(
                            child: Text(
                              e,
                              textDirection: TextDirection.rtl,
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
  }

  static showCheckedModalBottomWidget({
    Size mediaQuery,
    BuildContext context,
    List<String> items,
    Function(String) onTap,
    String checkItem,
  }) {
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
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: mediaQuery.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  // top: BorderSide(
                                  //   color: Theme.of(context).primaryColor,
                                  // ),
                                  bottom: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              height: mediaQuery.height * 0.1,
                              child: Center(
                                child: Text(
                                  e,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            Positioned(
                              top: mediaQuery.height * 0.03,
                              left: mediaQuery.width * 0.1,
                              child: Visibility(
                                visible: e == checkItem,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    ).then(onTap);
  }

  static showFilterModalBottomWidget({
    Size mediaQuery,
    BuildContext context,
    List<Widget> children,
    Function onAccept,
    Function onCancel,
  }) {
    showModalBottomSheet<String>(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...children,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Center(
                          child: Container(
                            width: mediaQuery.width * 0.3,
                            child: RegisterButton(
                              title: 'موافق',
                              // color: Colors.red,
                              onPressed: onAccept,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Center(
                          child: Container(
                            width: mediaQuery.width * 0.3,
                            child: RegisterButton(
                              title: 'إلغاء',
                              color: Colors.red,
                              onPressed: onCancel,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static showFilePickerSheet({
    Size mediaQuery,
    BuildContext context,
    File sentPhoto,
    SocketUtils socketUtils,
    int conversationId,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: Colors.black,
                    //     width: 1,
                    //   ),
                    // ),
                    child: Center(
                        child: sentPhoto == null
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.grey),
                                height: mediaQuery.height * 0.2,
                                width: mediaQuery.width * 0.4,
                                child: InkWell(
                                  onTap: () {
                                    ImagePickerDialog().show(
                                        context: context,
                                        onGet: (file) {
                                          if (file != null) {
                                            setState(() {
                                              sentPhoto = file;
                                              // onPickImage(file);
                                            });
                                            print('sss');
                                          } else {
                                            return;
                                          }
                                        });
                                  },
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.file(sentPhoto)),
                                ],
                              )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: sentPhoto != null,
                        child: Card(
                          elevation: 8,
                          shape: CircleBorder(),
                          color: Theme.of(context).primaryColor,
                          child: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Color(0xffA4BE25),
                              ),
                              onPressed: () async {
                                var link =
                                    await Provider.of<MyConversationsProvider>(
                                            context,
                                            listen: false)
                                        .uploadFile(
                                  context,
                                  image: sentPhoto,
                                  conversationId: conversationId,
                                );
                                if (link != null) {
                                  if (link.data != null) {
                                    socketUtils.sendMessage(
                                      ChatMessageModel(
                                        apiToken: Provider.of<
                                                    SharedPreferencesProvider>(
                                                context,
                                                listen: false)
                                            .prefs
                                            .get('token'),
                                        senderId: Provider.of<
                                                    SharedPreferencesProvider>(
                                                context,
                                                listen: false)
                                            .prefs
                                            .get('id'),
                                        message: null,
                                        chatFile: link.data,
                                        conversationId: conversationId,
                                        senderImage: Provider.of<
                                                    SharedPreferencesProvider>(
                                                context,
                                                listen: false)
                                            .prefs
                                            .get('image'),
                                        senderName: Provider.of<
                                                    SharedPreferencesProvider>(
                                                context,
                                                listen: false)
                                            .prefs
                                            .get('name'),
                                      ),
                                    );
                                  }
                                }
                                Navigator.of(context).pop();
                              }),
                        ),
                      ),
                      Spacer(),
                      Visibility(
                        visible: sentPhoto != null,
                        child: Card(
                          elevation: 8,
                          shape: CircleBorder(),
                          color: Theme.of(context).primaryColor,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              ImagePickerDialog().show(
                                  context: context,
                                  onGet: (file) {
                                    if (file != null) {
                                      setState(() {
                                        sentPhoto = file;
                                        // onPickImage(file);
                                      });
                                      print('sss');
                                    } else {
                                      return;
                                    }
                                  });
                            },
                          ),
                        ),
                      ),
                    ].reversed.toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
