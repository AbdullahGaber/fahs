import 'package:flutter/material.dart';

class MyFavoritesScreen extends StatefulWidget {
  @override
  _MyFavoritesScreenState createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'مفضلاتي',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Expanded(
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (ctx, i) => ProviderItem(
                          providerDistance: 1.5,
                          providerImage: 'assets/images/log.png',
                          providerName: 'مركز تجربة',
                          providerRate: 4.5,
                          serviceCost: '45215',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => ProviderProfileScreen(),
                            ));
                          },
                        ),
                      ),
                    ),
      ),
    );
  }
}
