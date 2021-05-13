import 'package:fahs/src/screens/maps/pick_location_screen.dart';
import 'package:fahs/src/widgets/modal_bottom_widget.dart';
import 'package:fahs/src/widgets/provider_item.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:fahs/src/widgets/size_widget.dart';
import 'package:fahs/src/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/text_field_widget.dart';

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
    'فيات',
  ];
  List<String> models = [
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
  ];
  //...
  String carLabel = 'اختر نوع السيارة';
  String modelLabel = 'اختر الموديل';
  String name;
  String accountNumber;
  File
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
          SizedBox(
            height: mediaQuery.height*0.04,
          ),
          TextFieldWidget(onChanged: onChanged)
            SizedBox(
              height: mediaQuery.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'نوع السيارة',
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ModalBottomWidget.showModalBottomWidget(
                    context: context,
                    items: cars,
                    mediaQuery: mediaQuery,
                    onTap: (e) {
                      if (e == null) {
                        return;
                      }
                      setState(() {
                        carLabel = e;
                      });
                    });
              },
              child: TextFieldWidget(
                onChanged: null,
                enableText: false,
                labelText: carLabel,
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            InkWell(
              onTap: () {
                ModalBottomWidget.showModalBottomWidget(
                    context: context,
                    items: models,
                    mediaQuery: mediaQuery,
                    onTap: (e) {
                      if (e == null) {
                        return;
                      }
                      setState(() {
                        modelLabel = e;
                      });
                    });
              },
              child: TextFieldWidget(
                onChanged: null,
                enableText: false,
                labelText: modelLabel,
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.1,
            ),
            Container(
              height: mediaQuery.height * 0.07,
              child: RegisterButton(
                title: 'انتقل لتحديد الموقع',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => PickLocationScreen(
                        isOrder: true,
                      ),
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
