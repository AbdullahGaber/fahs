import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../logic/providers/auth/signup_provider.dart';
import '../../logic/providers/general/cities_provider.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/modal_bottom_widget.dart';
import '../../widgets/text_field_widget.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import '../../widgets/register_button.dart';
import '../../helper/image_picker_dialog.dart';
import '../../logic/models/general/regions_model.dart';
import '../../logic/providers/general/regions_provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  List<Datum> regions = [];
  RegionsProvider regionsProvider;
  List<String> cities = ['جدة', 'الرياض'];
  String cityLabel = 'المدينة';
  String regionLabel = 'المنطقة';
  bool isUserSignUp = false;
  bool securePassword = true;
  bool secureConfirmPassword = true;
  bool agreeRules = false;
  File logoImage;
  File insuranceImage;
  bool isInit = true;
  bool isLoading = false;
  bool isCityLoading = false;

  SignupProvider signupProvider;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      signupProvider = Provider.of<SignupProvider>(context, listen: false);
      setState(() {
        isUserSignUp = signupProvider.type == 0;
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  Future<bool> back() async {
    // signupProvider.
    Phoenix.rebirth(context);
    print('kkk;');

    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(signupProvider.name);
    var mediaQuery = MediaQuery.of(context).size;
    var cityProvider = Provider.of<CitiesProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: back,
      child: Container(
        child: Scaffold(
          body: isLoading
              ? AppLoader()
              : SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mediaQuery.height * 0.06,
                      ),
                      Image.asset(
                        'assets/images/icon005.png',
                        height: mediaQuery.height * 0.25,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          !isUserSignUp
                              ? 'تسجيل جديد كمزود خدمة'
                              : 'تسجيل جديد كعميل',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.07,
                      ),
                      TextFieldWidget(
                        labelText: 'الاسم',
                        onChanged: (v) => setState(
                          () => signupProvider.name = v,
                        ),
                      ),
                      TextFieldWidget(
                        labelText: 'رقم الجوال',
                        keyboardType: TextInputType.number,
                        initialValue: signupProvider.phone,
                        onChanged: null,
                        enableText: false,
                      ),
                      TextFieldWidget(
                        labelText: 'البريد الالكتروني',
                        onChanged: (v) => setState(
                          () => signupProvider.email = v,
                        ),
                      ),
                      logoImage == null
                          ? InkWell(
                              onTap: () {
                                ImagePickerDialog().show(
                                  context: context,
                                  onGet: (file) {
                                    print(file.path);
                                    setState(() {
                                      logoImage = file;
                                    });
                                    signupProvider.image = file;
                                  },
                                );
                              },
                              child: TextFieldWidget(
                                labelText: isUserSignUp
                                    ? 'الصورة الشخصية'
                                    : 'شعار المصنع',
                                enableText: false,
                                onChanged: null,
                                suffixIcon: Icon(
                                  Typicons.export,
                                  color: Color(0xffFECB00),
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
                                      image: FileImage(logoImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: mediaQuery.width * 0.01,
                                  top: mediaQuery.height * 0.01,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.3),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          logoImage = null;
                                        });
                                        // signupProvider.image = null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Visibility(
                        visible: !isUserSignUp,
                        child: TextFieldWidget(
                          labelText: 'حدد العنوان',
                          enableText: false,
                          onChanged: null,
                          suffixIcon: Icon(
                            Icons.add_location,
                            color: Color(0xffFECB00),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isUserSignUp,
                        child: TextFieldWidget(
                          labelText: 'حدد سعر الخدمة',
                          onChanged: (v)=>signupProvider.serviceCost = v,
                          suffixIcon: Icon(
                            FontAwesomeIcons.dollarSign,
                            color: Color(0xffFECB00),
                          ),
                        ),
                      ),
                      TextFieldWidget(
                        labelText: 'كلمة المرور',
                        secureText: securePassword,
                        onChanged: (v) =>
                            setState(() => signupProvider.password = v),
                        suffixIcon: IconButton(
                          icon: Icon(
                            securePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 15,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              securePassword = !securePassword;
                            });
                          },
                        ),
                      ),
                      TextFieldWidget(
                        labelText: 'تأكيد كلمة المرور',
                        secureText: secureConfirmPassword,
                        onChanged: (v) => setState(
                            () => signupProvider.passwordConfirmation = v),
                        suffixIcon: IconButton(
                          icon: Icon(
                            secureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 15,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              secureConfirmPassword = !secureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: mediaQuery.width * 0.07,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'أوافق على كافة الشروط والأحكام',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Checkbox(
                                  value: agreeRules,
                                  onChanged: (value) {
                                    setState(() {
                                      agreeRules = value;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      RegisterButton(
                        title: 'تسجيل',
                        onPressed: ((agreeRules == false &&
                                    signupProvider.type == 0 &&
                                    ((signupProvider.name.isEmpty ||
                                        logoImage == null ||
                                        signupProvider.password.isEmpty ||
                                        signupProvider
                                            .passwordConfirmation.isEmpty))) ||
                                (agreeRules == false &&
                                    signupProvider.type == 1 &&
                                    ((signupProvider.name.isEmpty ||
                                        
                                        signupProvider.password.isEmpty ||
                                        signupProvider
                                            .passwordConfirmation.isEmpty ||
                                        signupProvider.serviceCost.isEmpty ||
                                      
                                        insuranceImage == null))))
                            ? null
                            : () async {
                                if (!agreeRules) {
                                  Fluttertoast.showToast(
                                    msg: 'يجب الموافقة على الشروط واﻷحكام',
                                    backgroundColor: Colors.red,
                                  );
                                  return;
                                }
                                // await signupProvider.signUp(context);
                              },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    signupProvider.disposev();
    super.dispose();
  }
}
