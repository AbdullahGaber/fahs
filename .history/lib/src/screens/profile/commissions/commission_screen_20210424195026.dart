import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/app_loader.dart';
import 'widgets/commissions_view_widget.dart';

class CommissionsScreen extends StatefulWidget {
  @override
  _CommissionsScreenState createState() => _CommissionsScreenState();
}

class _CommissionsScreenState extends State<CommissionsScreen>
    with SingleTickerProviderStateMixin {
  List<Notification> model = [
    Notification(
      'عنوان يتم استبداله بعنوان حقيقي',
      'تفاصيل المدفوعات يتم استبداله',
      DateTime.now(),
    ),
    Notification(
      'عنوان يتم استبداله بعنوان حقيقي',
      'تفاصيل المدفوعات يتم استبداله',
      DateTime.now(),
    ),
    Notification(
      'عنوان يتم استبداله بعنوان حقيقي',
      'تفاصيل المدفوعات يتم استبداله',
      DateTime.now(),
    ),
    Notification(
      'عنوان يتم استبداله بعنوان حقيقي',
      'تفاصيل المدفوعات يتم استبداله',
      DateTime.now(),
    ),
    Notification(
      'عنوان يتم استبداله بعنوان حقيقي',
      'تفاصيل المدفوعات يتم استبداله',
      DateTime.now(),
    ),
    Notification(
      'عنوان يتم استبداله بعنوان حقيقي',
      'تفاصيل المدفوعات يتم استبداله',
      DateTime.now(),
    ),
  ];
  TabController controller;
  bool isInit = true;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'عمولاتي',
              ),
            ),
            toolbarHeight: mediaQuery.height * 0.15,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
            // bottom: TabBar(
            //             indicator: BoxDecoration(
            //                 border: Border.all(color: Colors.transparent)),
            //             tabs: [
            //               Text('عمولاتي المستحقة'),
            //               Text('عمولاتي المدفوعة'),
            //             ],
            //             controller: controller,
            //             labelColor: Color(0xffA4BE25),
            //             unselectedLabelColor: Colors.white,
            //           ),
          ),
          body: CommissionsViewWidget(
            payedCommissions: false,
            myCommissions: model,
          ),
          // body: FutureBuilder<CommissionsModel>(
          //   future: commissionsProvider.getMyCommissions(context),
          //   builder: (ctx, snapShot) {
          //     if (snapShot.connectionState == ConnectionState.none) {
          //       return Center(
          //         child: Text(
          //           'يرجى التحقق من الاتصال بالانترنت',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       );
          //     }
          //     if (snapShot.connectionState == ConnectionState.waiting) {
          //       return AppLoader();
          //     }
          //     if (snapShot.connectionState == ConnectionState.done &&
          //         snapShot.data.error != null) {
          //       return Center(
          //         child: Text(
          //           snapShot.data.error[0].value,
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       );
          //     }
          //     return Consumer<CommissionsProvider>(
          //       builder: (_, snap, __) {
          //         if (snap.myCommissions.isEmpty) {
          //           return Center(
          //             child: Text(
          //               'لا يوجد بيانات حاليا',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           );
          //         }
          //         return TabBarView(
          //           controller: controller,
          //           children: [
          //             CommissionsViewWidget(
          //               payedCommissions: false,
          //               myCommissions: snap.findSpecificCommissions(
          //                   payedCommissions: false),
          //             ),
          //             CommissionsViewWidget(
          //               payedCommissions: true,
          //               myCommissions: snap.findSpecificCommissions(
          //                   payedCommissions: true),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
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
