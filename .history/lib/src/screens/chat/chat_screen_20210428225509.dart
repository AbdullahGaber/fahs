import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logic/models/chat/chat_message_model.dart';
import '../../logic/providers/general/settings_provider.dart';
import '../../logic/providers/general/shared_preferences_provider.dart';
import '../../screens/chat/widget/send_widget.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/modal_bottom_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../screens/chat/widget/message_bubble.dart';
import 'package:provider/provider.dart';
import '../../logic/providers/chat/create_chat_provider.dart';
import '../chat/socket.io/socket_utils.dart';
import '../../logic/providers/chat/my_conversations_provider.dart';
import '../../logic/models/chat/conversations_model.dart';
import 'package:stream_transform/stream_transform.dart';

class ChatScreen extends StatefulWidget {
  final int conversationId;
  final int providerId;
  final String toUserName;
  final String toUserImage;
  final String toUserNumber;
  ChatScreen({
    this.conversationId,
    this.providerId,
    @required this.toUserName,
    @required this.toUserImage,
    @required this.toUserNumber,
  });
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  StreamController _controller = StreamController();
  bool emitTyping = false;
  bool showTypingIndicator = false;
  int conversationId;
  SettingsProvider settingsProvider;
  SharedPreferences prefs;
  MyConversationsProvider getMyConversationsProvider;
  File image;
  onConnect(data) {
    print('connect $data');
    if (networkError.isNotEmpty) {
      setState(() {
        networkError = 'تم الاتصال بنجاح';
        if (getMyConversationsProvider.myConversationsMessages.isEmpty) {
          // getMyChat();
          print('aadd');
        }
      });
      Future.delayed(
          Duration(
            seconds: 1,
          ), () {
        setState(() {
          networkError = '';
        });
      });
    }
  }

  onConnectError(data) {
    setState(() {
      networkError = 'يرجى التحقق من الاتصال بالانترنت';
    });
    print('connect error $data');
  }

  userConnectedListener(data) {
    if ((data as Map).isNotEmpty) {
      if ((data as Map).containsKey('api_token')) {
        if (data['api_token'] != prefs.get('token')) {
          setState(() {
            connectStatus = 'متصل الان';
          });
        }
        if (connectStatus == 'جاري الاتصال...') {
          setState(() {
            connectStatus = 'غير متصل';
          });
        }
        if (data['api_token'] != prefs.get('token')) {
          getMyConversationsProvider.changeSeenStatus();
        }
      }
    }
    print('user connect error $data');
  }

  userDisconnectedListener(data) {
    print('disconnect  $data');
  }

  onConnectErrorTimeout(data) {
    print('connect error timeout $data');
  }

  onError(data) {
    print('error $data');
  }

  onUserTyping(data) {
    print('here $data');
    if (data['api_token'] != prefs.get('token')) {
      setState(() {
        showTypingIndicator = true;
      });
    }
  }

  onUserStopped(data) {
    if (data['api_token'] != prefs.get('token')) {
      setState(() {
        showTypingIndicator = false;
      });
    }

    print('error $data');
  }

  onDisconnectError(data) {
    if (data['phone'] != prefs.get('phone') &&
        data['phone'] != '' &&
        data['phone'] != null) {
      setState(() {
        connectStatus = 'غير متصل';
      });
    }
    print('disconnect $data');
  }

  onMessageRecieved(data) async {
    bool isMe = data == null ? false : data["user_id"] == prefs.get('id');
    await AudioCache().play(
      'sound/sent.wav',
    );
    print('recieved: $data');

    getMyConversationsProvider.addNewMessages(
      Datum(
        id: data['id'],
        createdAt: data['created_at'],
        file: data['file'] == null
            ? null
            : 'https://tameercom.tqnee.com/uploads/chats/' + data["file"],
        message: data['message'],
        seen: connectStatus == 'متصل الان' ? 1 : 0,
        senderId: data['user_id'],
        senderImage:
            isMe ? prefs.get('image') : widget.toUserImage /*data["img"]*/,
        senderName:
            isMe ? prefs.get('name') : widget.toUserName /*data["name"]*/,
      ),
    );
  }

  initialSocket() async {
    print('conv $conversationId ${widget.conversationId}');
    Future.delayed(Duration(seconds: 2), () async {
      socketUtils = SocketUtils();
      await socketUtils.initSocket(
        conversationId ?? widget.conversationId,
        context,
      );
      socketUtils.setOnConnectListener(onConnect);
      socketUtils.setOnConnectErrorTimeOutListener(onConnectErrorTimeout);
      socketUtils.setDisconnectListener(onDisconnectError);
      socketUtils.setOnErrorListener(onError);
      socketUtils.setOnConnectErrorListener(onConnectError);
      socketUtils.receiveMessage(onMessageRecieved);
      socketUtils.userConnect(
        userConnectedListener,
        context,
      );
      socketUtils.onUserTypingListener(onUserTyping);
      socketUtils.onUserStopTypingListener(onUserStopped);

      socketUtils.userDisconnect(userDisconnectedListener);
      // await socketUtils.connectToSocket();
    });
  }

  String message = '';
  List<String> messages = ['مرحبا'];
  var controller = TextEditingController();
  String connectStatus = 'جاري الاتصال...';
  String networkError = '';
  bool isInit = true;
  bool isLoading = false;
  String errorMessage;
  SocketUtils socketUtils;
  // @override
  // void initState() {
  //   _controller.stream.transform(debounce(Duration(seconds: 1))).listen(
  //     (e) {
  //       socketUtils.onUserStopTyping(context, onUserStopped);
  //     },
  //   );
  //   super.initState();
  // }

  // Future<void> getMyChat() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   prefs =
  //       Provider.of<SharedPreferencesProvider>(context, listen: false).prefs;
  //   settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
  //   await settingsProvider.getSettings(context);
  //   if (widget.conversationId == null) {
  //     var createChat = Provider.of<CreateChatProvider>(context, listen: false);
  //     var create = await createChat.startChat(
  //       context,
  //       providerId: widget.providerId,
  //     );
  //     if (create != null) {
  //       conversationId = create.data.conversationId;
  //     } else {
  //       errorMessage = 'يرجى التحقق من الاتصال بالانترنت';
  //     }
  //   }
  //   await getMyConversationsProvider.getConversationsMessages(
  //     context,
  //     conversationId: conversationId ?? widget.conversationId,
  //   );

  //   initialSocket();

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // @override
  // void didChangeDependencies() async {
  //   if (isInit) {
  //     getMyConversationsProvider =
  //         Provider.of<MyConversationsProvider>(context, listen: false);
  //     await getMyChat();
  //   }
  //   isInit = false;
  //   super.didChangeDependencies();
  // }

  // @override
  // void dispose() {
  //   if (socketUtils != null) {
  //     socketUtils.closeConnection();
  //   }
  //   getMyConversationsProvider.disposeMessages();
  //   _controller.close();
  //   super.dispose();
  // }
  //
  //
  @override
  void initState() {
    messages = messages.reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/background.jpg',
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  String tel = '2545242424';
                  print(tel);
                  if (!tel.startsWith('+966')) {
                    tel = '+966$tel';
                  }
                  launch('tel:$tel');
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.toUserName),
                    Visibility(
                      visible: networkError.isEmpty ||
                          networkError == 'تم الاتصال بنجاح',
                      child: Text(
                        connectStatus,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        // body: Directionality(
        //   textDirection: TextDirection.rtl,
        //   child: Column(
        //     children: [
        //       Visibility(
        //         visible: networkError.isNotEmpty,
        //         child: Container(
        //           color: networkError == 'تم الاتصال بنجاح'
        //               ? Colors.green
        //               : Colors.red,
        //           width: mediaQuery.width,
        //           padding: EdgeInsets.symmetric(
        //             vertical: 10,
        //             horizontal: 5,
        //           ),
        //           child: Text(
        //             networkError,
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 13,
        //             ),
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         child: isLoading
        //             ? AppLoader()
        //             : Consumer<MyConversationsProvider>(
        //                 builder: (_, snap, __) {
        //                   if (snap.myConversationsMessages.isEmpty) {
        //                     return Center(
        //                       child: Text(
        //                         'لا يوجد رسائل',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.bold,
        //                         ),
        //                       ),
        //                     );
        //                   }

        //                   return ListView.builder(
        //                       reverse: true,
        //                       itemCount: snap.myConversationsMessages.length,
        //                       itemBuilder: (ctx, i) {
        //                         return Padding(
        //                           padding:
        //                               const EdgeInsets.symmetric(vertical: 5),
        //                           child: MessageBubble(
        //                             message:
        //                                 snap.myConversationsMessages[i].message,
        //                             userName: snap
        //                                 .myConversationsMessages[i].senderName,
        //                             userImage: snap
        //                                 .myConversationsMessages[i].senderImage,
        //                             createdAt: snap
        //                                 .myConversationsMessages[i].createdAt,
        //                             isMe: prefs.get('id') ==
        //                                 snap.myConversationsMessages[i]
        //                                     .senderId,
        //                             seen:
        //                                 snap.myConversationsMessages[i].seen ==
        //                                     1,
        //                             imageUrl:
        //                                 snap.myConversationsMessages[i].file,
        //                             isImage: snap.myConversationsMessages[i]
        //                                         .message ==
        //                                     null ||
        //                                 snap.myConversationsMessages[i].message
        //                                     .isEmpty,
        //                           ),
        //                         );
        //                       });
        //                 },
        //               ),
        //       ),
        //       Visibility(
        //         visible: showTypingIndicator,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               '${widget.toUserName} يكتب الآن',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 12,
        //               ),
        //             ),
        //             SpinKitThreeBounce(
        //               color: Colors.white,
        //               size: 15,
        //             ),
        //           ],
        //         ),
        //       ),
        //       SendWidget(
        //           onSendFile: networkError.isNotEmpty
        //               ? null
        //               : () async {
        //                   await ModalBottomWidget.showFilePickerSheet(
        //                     mediaQuery: mediaQuery,
        //                     context: context,
        //                     sentPhoto: image,
        //                     conversationId:
        //                         conversationId ?? widget.conversationId,
        //                     socketUtils: socketUtils,
        //                   );

        //                   print('sssf');
        //                 },
        //           message: message,
        //           controller: controller,
        //           onChanged: (v) {
        //             _controller.add(v);
        //             setState(() {
        //               message = v;

        //               socketUtils.onUserTyping(context, onUserTyping);
        //             });
        //           },
        //           sendMessage: message.trim().isEmpty
        //               ? null
        //               : message.trim().isNotEmpty &&
        //                       networkError == 'يرجى التحقق من الاتصال بالانترنت'
        //                   ? null
        //                   : () {
        //                       socketUtils.sendMessage(
        //                         ChatMessageModel(
        //                           apiToken:
        //                               Provider.of<SharedPreferencesProvider>(
        //                                       context,
        //                                       listen: false)
        //                                   .prefs
        //                                   .get('token'),
        //                           senderId: prefs.get('id'),
        //                           message: message,
        //                           chatFile: null,
        //                           conversationId:
        //                               conversationId ?? widget.conversationId,
        //                           senderImage: prefs.get('image'),
        //                           senderName: prefs.get('name'),
        //                         ),
        //                       );
        //                       setState(() {
        //                         controller.clear();
        //                         message = '';
        //                       });
        //                     }),
        //     ],
        //   ),
        // ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
              reverse: true,
              itemCount: snap.myConversationsMessages.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MessageBubble(
                    message: snap.myConversationsMessages[i].message,
                    userName: snap.myConversationsMessages[i].senderName,
                    userImage: snap.myConversationsMessages[i].senderImage,
                    createdAt: snap.myConversationsMessages[i].createdAt,
                    isMe: prefs.get('id') ==
                        snap.myConversationsMessages[i].senderId,
                    seen: snap.myConversationsMessages[i].seen == 1,
                    imageUrl: snap.myConversationsMessages[i].file,
                    isImage: snap.myConversationsMessages[i].message == null ||
                        snap.myConversationsMessages[i].message.isEmpty,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
