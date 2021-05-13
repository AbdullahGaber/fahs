import 'dart:io';

import 'package:fahs/src/screens/maps/pick_location_screen.dart';
import 'package:fahs/src/screens/user/providers/service_confirmation_screen.dart';
import 'package:fahs/src/widgets/modal_bottom_widget.dart';
import 'package:fahs/src/widgets/provider_item.dart';
import 'package:fahs/src/widgets/register_button.dart';
import 'package:fahs/src/widgets/size_widget.dart';
import 'package:fahs/src/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../helper/image_picker_dialog.dart';
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
  String name = '';
  String accountNumber = '';
  File pickedImage;
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
        child: SingleChildScrollView(
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
                height: mediaQuery.height * 0.05,
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
                height: mediaQuery.height * 0.04,
              ),
              TextFieldWidget(
                onChanged: (v) {
                  setState(() {
                    name = v;
                  });
                },
                labelText: 'اسم البنك',
              ),
              TextFieldWidget(
                onChanged: (v) {
                  setState(() {
                    accountNumber = v;
                  });
                },
                labelText: 'رقم الحساب',
              ),
              pickedImage == null
                  ? InkWell(
                      onTap: () {
                        ImagePickerDialog().show(
                          context: context,
                          onGet: (file) {
                            print(file.path);
                            setState(() {
                              pickedImage = file;
                            });
                          },
                        );
                      },
                      child: TextFieldWidget(
                        labelText: 'صورة الدفع',
                        enableText: false,
                        onChanged: null,
                        suffixIcon: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Container(
                          width: mediaQuery.width * 0.8,
                          height: mediaQuery.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            image: DecorationImage(
                              image: FileImage(pickedImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: mediaQuery.width * 0.01,
                          top: mediaQuery.height * 0.01,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  pickedImage = null;
                                });
                                // signupProvider.image = null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: mediaQuery.height * 0.05,
              ),
              SizedBox(
                height: mediaQuery.height * 0.05,
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
                height: mediaQuery.height * 0.05,
              ),
              Container(
                height: mediaQuery.height * 0.07,
                child: RegisterButton(
                  isActiveColor: (name.isNotEmpty &&
                      accountNumber.isNotEmpty &&
                      pickedImage != null &&
                      carLabel != 'اختر نوع السيارة' &&
                      modelLabel != 'اختر الموديل'),
                  title: 'انتقل لتأكيد الخدمة',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => ServiceConfirmationScreen(
                          bankName: name,
                          accountNumber: accountNumber,
                          carMark: carLabel,
                          carModel: modelLabel,
                          paymentImage: pickedImage,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
