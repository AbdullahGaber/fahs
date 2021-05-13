import 'package:fahs/src/widgets/provider_item.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:flutter/material.dart';

class RequestServiceScreen extends StatefulWidget {
  @override
  _RequestServiceScreenState createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  //dummy data.
  List<String> cars = [
    'مرسيدس',
    'شيفروليه',
    'كيا',
    
  ];
  //...
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
              height: mediaQuery.height * 0.3,
            ),
            Container(
              height: mediaQuery.height * 0.07,
              child: RegisterButton(
                title: 'طلب خدمة',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
