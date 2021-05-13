import 'package:fahs/src/screens/user/order/order_details_screen.dart';
import 'package:fahs/src/widgets/order_widget.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatefulWidget {
  final int type;
  MyOrdersScreen({
    this.type,
  });
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = TabController(length: widget.type == 0?3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.type);
    var mediaQuery = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: widget.type == 0
            ? AppBar(
                toolbarHeight: mediaQuery.height * 0.044,
                bottom: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff20C3BA),
                        Color(0xff4CCA93),
                        Color(0xff5CCC85),
                        Color(0xff98D651),
                        Color(0xffA7D943),
                        Color(0xffCADF24),
                      ],
                      end: Alignment.centerLeft,
                      begin: Alignment.centerRight,
                    ),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  controller: controller,
                  tabs: [
                    Text(
                      'بانتظار التأكيد',
                    ),
                    Text(
                      'نشط',
                    ),
                    Text(
                      'منتهي',
                    ),
                  ],
                ),
              )
            : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text('طلباتي'),
                ),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
                bottom: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff20C3BA),
                        Color(0xff4CCA93),
                        Color(0xff5CCC85),
                        Color(0xff98D651),
                        Color(0xffA7D943),
                        Color(0xffCADF24),
                      ],
                      end: Alignment.centerLeft,
                      begin: Alignment.centerRight,
                    ),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  controller: controller,
                  tabs: [
                    Text(
                      'بانتظار التأكيد',
                    ),
                    Text(
                      'نشط',
                    ),
                    Text(
                      'منتهي',
                    ),
                  ],
                ),
              ),
        body: TabBarView(
          controller: controller,
          children: [
            Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => OrderDetailsScreen(
                              showAcceptButton: widget.type == 1),
                        ),
                      );
                    },
                    child: OrderWidget(
                      orderTitle: 'عنوان مختصر للطلب',
                      providerName: 'اسم مزود الخدمة',
                      price: '54545',
                      orderId: 15,
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => OrderDetailsScreen(),
                        //   ),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
