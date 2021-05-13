import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../logic/models/general/notifications/notifications_model.dart';
import '../../logic/providers/general/notifications/notifications_provider.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/custom_new_dialog.dart';

import '../../logic/providers/general/shared_preferences_provider.dart';
import '../tab_screen.dart';
import 'Widgets/notificationCard.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  CustomDialog _dialog = CustomDialog();
  List<Notification> model = [
    Notification('عنوان اشعار يتم استبداله بعنوان حقيقي',
        'تفاصيل الاشعار يتم استبداله', DateTime.now())
  ];
  bool isInit = true;
  bool isLoading = false;
  @override
  // void didChangeDependencies() async {
  //   if (isInit) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     var data = Provider.of<NotificationsProvider>(context, listen: false);
  //     var dataNotification = await data.getNotifications(context);
  //     if (dataNotification.data != null) {
  //       if (data.unReadNotification > 0) {
  //         await data.readAllNotifications();
  //       }
  //     } else {}
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  //   isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("الاشعارات"),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: model.isEmpty
              ? Center(
                  child: Text(
                    'لا يوجد بيانات حاليا',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              : ListView(
                  // shrinkWrap: true,

                  children: <Widget>[
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                          ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      itemCount: model.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {},
                          child: NotificationCard(
                            model: null,
                            title: model[index].title,
                            message: model[index].message,
                            onTap: () async {
                              var dialog = CustomDialog();
                              await dialog.showOptionDialog(
                                  context: context,
                                  msg: ' هل أنت متأكد؟',
                                  okFun: () {
                                    setState(() {
                                      model.removeAt(index);
                                    });
                                  },
                                  okMsg: 'نعم',
                                  cancelFun: () {
                                    return;
                                  },
                                  cancelMsg: 'لا');
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
          // child: FutureBuilder(
          //   future: Provider.of<NotificationsProvider>(context, listen: false)
          //       .getNotifications(context),
          //   builder: (ctx, AsyncSnapshot<NotificationsModel> data) => data
          //               .connectionState ==
          //           ConnectionState.waiting
          //       ? AppLoader()
          //       : data.data.error != null
          //           ? Center(
          //               child: Text(
          //               data.data.error[0].value,
          //               style: TextStyle(
          //                 fontSize: 25,
          //                 color: Colors.white,
          //               ),
          //             ))
          //           : data.data == null
          //               ? Center(
          //                   child: Text(
          //                   'يرجى التحقق من الاتصال بالانترنت',
          //                   style: TextStyle(
          //                     fontSize: 25,
          //                     color: Colors.white,
          //                   ),
          //                 ))
          //               : Consumer<NotificationsProvider>(
          //                   builder: (ctx, snap, _) {
          //                     if (snap.myNotification.isEmpty) {
          //                       return Center(
          //                           child: Text(
          //                         'لا يوجد بيانات حاليا',
          //                         style: TextStyle(
          //                           fontSize: 25,
          //                           color: Colors.white,
          //                         ),
          //                       ));
          //                     }
          //                     return ListView(
          //                       // shrinkWrap: true,

          //                       children: <Widget>[
          //                         SizedBox(height: 20),
          //                         ListView.builder(
          //                           shrinkWrap: true,
          //                           physics: ScrollPhysics(
          //                               parent: NeverScrollableScrollPhysics()),
          //                           itemCount: snap.myNotification.length,
          //                           itemBuilder: (context, index) {
          //                             return InkWell(
          //                               onTap: snap.myNotification[index]
          //                                           .type ==
          //                                       4
          //                                   ? null
          //                                   : () async {
          //                                       if (snap.myNotification[index]
          //                                               .orderId >
          //                                           0) {
          //                                         Navigator.of(context)
          //                                             .pushAndRemoveUntil(
          //                                           MaterialPageRoute(
          //                                             builder: (_) => TabScreen(
          //                                               index: 2,
          //                                               type: Provider.of<SharedPreferencesProvider>(
          //                                                               context,
          //                                                               listen:
          //                                                                   false)
          //                                                           .prefs
          //                                                           .get(
          //                                                               'type') ==
          //                                                       'عميل'
          //                                                   ? 0
          //                                                   : 1,
          //                                             ),
          //                                           ),
          //                                           (route) => false,
          //                                         );
          //                                       }
          //                                     },
          //                               child: NotificationCard(
          //                                 key: ValueKey(
          //                                     snap.myNotification[index].id),
          //                                 model: snap.myNotification[index],
          //                                 title:
          //                                     snap.myNotification[index].title,
          //                                 message: snap
          //                                     .myNotification[index].message,
          //                                 onTap: () async {
          //                                   await _dialog.showOptionDialog(
          //                                       context: context,
          //                                       msg: 'هل أنت متأكد؟',
          //                                       okFun: () async {
          //                                         var remove = Provider.of<
          //                                                 NotificationsProvider>(
          //                                             context,
          //                                             listen: false);
          //                                         var isDeleted = await remove
          //                                             .deleteNotification(
          //                                                 snap
          //                                                     .myNotification[
          //                                                         index]
          //                                                     .id,
          //                                                 context);
          //                                         if (!isDeleted) {
          //                                           Fluttertoast.showToast(
          //                                             msg:
          //                                                 'يرجى التحقق من الاتصال بالانترنت',
          //                                           );
          //                                         } else {
          //                                           Fluttertoast.showToast(
          //                                             msg: 'تم الحذف',
          //                                           );
          //                                         }
          //                                       },
          //                                       okMsg: 'نعم',
          //                                       cancelMsg: 'لا',
          //                                       cancelFun: () {
          //                                         return;
          //                                       });
          //                                 },
          //                               ),
          //                             );
          //                           },
          //                         )
          //                       ],
          //                     );
          //                   },
          //                 ),
          // ),
        ),
      ),
    );
  }
}

class Notification {
  final String title;

  final String message;
  final String setTitle;

  final DateTime createdAt;

  Notification(this.title, this.message, this.createdAt,
      {this.setTitle = "العنوان"});
}
