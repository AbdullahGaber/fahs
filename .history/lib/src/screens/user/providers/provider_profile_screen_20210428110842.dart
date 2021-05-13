import 'package:fahs/src/screens/user/providers/request_service_screen.dart';
import 'package:fahs/src/widgets/provider_item.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProviderProfileScreen extends StatefulWidget {
  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  bool isFavorite=false;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'مركز تجربة',
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            ProviderItem(
              providerDistance: 1.5,
              providerImage: 'assets/images/log.png',
              providerName: 'مركز تجربة',
              providerRate: 4.5,
              serviceCost: '45215',
              onPressed: null,
            ),
            SizedBox(
              height: mediaQuery.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'طريقة الدفع',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'تحويل بنكي',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.3,
            ),
            Container(
              height: mediaQuery.height * 0.07,
              child: RegisterButton(
                title: 'طلب خدمة',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => RequestServiceScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
