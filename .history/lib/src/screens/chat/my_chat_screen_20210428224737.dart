import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/models/chat/my_conversations_model.dart';
import '../../logic/providers/chat/my_conversations_provider.dart';
import '../../logic/providers/general/shared_preferences_provider.dart';
import '../../widgets/app_loader.dart';
import './chat_screen.dart';
import 'widget/conversations_widget.dart';

class MyChatScreen extends StatefulWidget {
  @override
  _MyChatScreenState createState() => _MyChatScreenState();
}

class _MyChatScreenState extends State<MyChatScreen> {
  @override
  Widget build(BuildContext context) {
    var prefs =
        Provider.of<SharedPreferencesProvider>(context, listen: false).prefs;
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerRight,
            child: Text('محادثاتي'),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body:  ListView.separated(
                  itemBuilder: (ctx, i) => ConversationsWidget(
                    imageUrl: 'assets',
                    userName:'عميل'
                    lastMessage: snapShot.data.data[i].lastMessage ?? 'صورة',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => ChatScreen(
                          conversationId: snapShot.data.data[i].id,
                          toUserImage: prefs.get('type') == 'عميل'
                              ? snapShot.data.data[i].providerImage
                              : snapShot.data.data[i].userImage,
                          toUserName: prefs.get('type') == 'عميل'
                              ? snapShot.data.data[i].providerName
                              : snapShot.data.data[i].userName,
                          toUserNumber: prefs.get('type') == 'عميل'
                              ? snapShot.data.data[i].providerPhone
                              : snapShot.data.data[i].userPhone,
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (_, __) => Divider(
                    color: Color(0xffA4BE25).withOpacity(0.6),
                  ),
                  itemCount: snapShot.data.data.length,
                )
        // body: FutureBuilder<MyConversationsModel>(
        //     future: Provider.of<MyConversationsProvider>(context, listen: false)
        //         .getMyConversations(context),
        //     builder: (ctx, snapShot) {
        //       if (snapShot.connectionState == ConnectionState.none) {
        //         return Center(
        //           child: Text(
        //             'يرجى التحقق من الاتصال بالانترنت',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         );
        //       }
        //       if (snapShot.connectionState == ConnectionState.waiting) {
        //         return AppLoader();
        //       } else {
        //         if (snapShot.hasData && snapShot.data.error != null) {
        //           return Center(
        //             child: Text(
        //               snapShot.data.error[0].value,
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           );
        //         }
        //         return ListView.separated(
        //           itemBuilder: (ctx, i) => ConversationsWidget(
        //             imageUrl: prefs.get('type') == 'عميل'
        //                 ? snapShot.data.data[i].providerImage
        //                 : snapShot.data.data[i].userImage,
        //             userName: prefs.get('type') == 'عميل'
        //                 ? snapShot.data.data[i].providerName
        //                 : snapShot.data.data[i].userName,
        //             lastMessage: snapShot.data.data[i].lastMessage ?? 'صورة',
        //             onTap: () => Navigator.of(context).push(
        //               MaterialPageRoute(
        //                 builder: (c) => ChatScreen(
        //                   conversationId: snapShot.data.data[i].id,
        //                   toUserImage: prefs.get('type') == 'عميل'
        //                       ? snapShot.data.data[i].providerImage
        //                       : snapShot.data.data[i].userImage,
        //                   toUserName: prefs.get('type') == 'عميل'
        //                       ? snapShot.data.data[i].providerName
        //                       : snapShot.data.data[i].userName,
        //                   toUserNumber: prefs.get('type') == 'عميل'
        //                       ? snapShot.data.data[i].providerPhone
        //                       : snapShot.data.data[i].userPhone,
        //                 ),
        //               ),
        //             ),
        //           ),
        //           separatorBuilder: (_, __) => Divider(
        //             color: Color(0xffA4BE25).withOpacity(0.6),
        //           ),
        //           itemCount: snapShot.data.data.length,
        //         );
        //       }
        //     }),
      ),
    );
  }
}
