import 'package:fahs/src/widgets/provider_item.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProviderProfileScreen extends StatefulWidget {
  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'مركز تجربة',
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
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
            Expande(
                          child: Container(
                height: mediaQuery.height * 0.07,
                child: RegisterButton(
                  title: 'طلب خدمة',
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
