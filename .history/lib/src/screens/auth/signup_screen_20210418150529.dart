import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      if (signupProvider.type == 1) {
        setState(() {
          isLoading = true;
        });
        regionsProvider = Provider.of<RegionsProvider>(context, listen: false);
        await regionsProvider.getRegions();
        regions = regionsProvider.myRegions;
        setState(() {
          isLoading = false;
        });
      }
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.07,
                      ),
                      Visibility(
                        visible: isUserSignUp,
                        child: TextFieldWidget(
                          labelText: 'الاسم',
                          onChanged: (v) => setState(
                            () => signupProvider.name = v,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isUserSignUp,
                        child: TextFieldWidget(
                          labelText: 'اسم المصنع',
                          onChanged: (v) => setState(
                            () => signupProvider.name = v,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isUserSignUp,
                        child: TextFieldWidget(
                          labelText: 'رقم السجل التجاري',
                          onChanged: (v) => setState(
                            () => signupProvider.commercialRecord = v,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Visibility(
                        visible: !isUserSignUp,
                        child: insuranceImage == null
                            ? InkWell(
                                onTap: () {
                                  ImagePickerDialog().show(
                                    context: context,
                                    onGet: (file) {
                                      setState(() {
                                        insuranceImage = file;
                                      });
                                      signupProvider.commercialImage = file;
                                    },
                                  );
                                },
                                child: TextFieldWidget(
                                  labelText: 'صورة السجل التجاري',
                                  enableText: false,
                                  suffixIcon: Icon(
                                    Typicons.export,
                                    color: Colors.white,
                                  ),
                                  onChanged: null,
                                ),
                              )
                            : Stack(
                                children: [
                                  Container(
                                    width: mediaQuery.width * 0.8,
                                    height: mediaQuery.height * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.file(
                                        insuranceImage,
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
                                            insuranceImage = null;
                                          });
                                          signupProvider.commercialImage = null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
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
                        child: InkWell(
                          onTap: () {
                            ModalBottomWidget.showModalBottomWidget(
                                context: context,
                                items: regions
                                    .map(
                                      (e) => e.name,
                                    )
                                    .toList(),
                                mediaQuery: mediaQuery,
                                onTap: (v) async {
                                  if (v != null) {
                                    setState(() {
                                      regionLabel = v;
                                      cityLabel = 'المدينة';
                                      isCityLoading = true;
                                    });
                                    var regionsId = (regions.firstWhere(
                                        (element) => element.name == v)).id;
                                    await cityProvider.getCities(
                                      regionId: regionsId,
                                    );
                                    setState(() {
                                      isCityLoading = false;
                                    });
                                  }
                                });
                          },
                          child: TextFieldWidget(
                            labelText: regionLabel,
                            enableText: false,
                            onChanged: null,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isUserSignUp,
                        child: InkWell(
                          onTap: () {
                            if (regionLabel == 'المنطقة') {
                              Fluttertoast.showToast(
                                  msg: 'يجب اختيار المنطقة أولاً');
                              return;
                            }
                            ModalBottomWidget.showModalBottomWidget(
                                context: context,
                                items: cityProvider.myCities
                                    .map((e) => e.name)
                                    .toList(),
                                mediaQuery: mediaQuery,
                                onTap: (v) {
                                  if (v != null) {
                                    setState(() {
                                      cityLabel = v;
                                    });
                                    signupProvider.cityId =
                                        (cityProvider.myCities.firstWhere(
                                            (element) => element.name == v)).id;
                                  }
                                });
                          },
                          child: TextFieldWidget(
                            labelText: cityLabel,
                            enableText: false,
                            onChanged: null,
                            suffixIcon: isCityLoading
                                ? SpinKitCircle(
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
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
                                        logoImage == null ||
                                        signupProvider.password.isEmpty ||
                                        signupProvider
                                            .passwordConfirmation.isEmpty ||
                                        signupProvider.cityId == null ||
                                        signupProvider
                                            .commercialRecord.isEmpty ||
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
