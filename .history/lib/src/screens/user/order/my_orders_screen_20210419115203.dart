import 'package:flutter/material.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text('طلباتي'),
          ),
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
                  Container(
                    height: mediaQuery.height * 0.2,
                    width: mediaQuery.width,
                    // child: Row(
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Text('اسم الطلب'),
                    //         Text('اسم الطلب'),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    child: ListTile(
                      title: Text(
                        'عنوان مختصر للطلب',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'اسم مزود الخدمة',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextSpan()
                              Text(
                                'SR 2151215',
                              ),
                              Text('رقم الطلب')
                            ],
                          )
                        ],
                      ),
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
