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
            se
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
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
