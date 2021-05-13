import 'package:country_code_picker/country_code_picker.dart';
import 'package:fahs/src/screens/mainScreens/home_screen.dart';
import 'package:fahs/src/screens/tab_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/providers/auth/login_provider.dart';
import '../../logic/providers/auth/signup_provider.dart';
import './choose_register_type_screen.dart';
import './mobile_register_screen.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/register_button.dart';
import 'mobile_register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool secureText = true;
  String code = '966';
  int type = 0;
  String get register =>
      type == 1 ? 'تسجيل حساب مزود خدمة جديد' : 'تسجيل حساب عميل جديد';
  String phone = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(
      context,
    ).size;
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: mediaQuery.height * 0.06,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/icon005.png',
                  height: mediaQuery.height * 0.25,
                ),
              ),

              SizedBox(
                height: mediaQuery.height * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.01,
              ),
              TextFieldWidget(
                labelText: 'رقم الجوال',
                keyboardType: TextInputType.number,
                onChanged: (v) => phone = v,
                // suffixIcon: Transform.scale(
                //   scale: 0.5,
                //   child: ImageIcon(
                //     AssetImage(
                //       'assets/icons/user.png',
                //     ),
                //     color: Color(0xff98D651),
                //   ),
                // ),
                // suffixIcon: Container(
                //   width: mediaQuery.width * 0.01,
                //   height: mediaQuery.width * 0.01,
                //   padding: EdgeInsets.symmetric(horizontal: 5),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(11),
                //     color: Colors.grey[400],
                //   ),
                //   child: Center(
                //     child: Text(
                //       code,
                //       style: TextStyle(
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
                suffixIcon: CountryCodePicker(
                  showFlag: false,
                  onChanged: (c) {
                    print('${c.name}&&${c.flagUri}&&${c.dialCode}**${c.flagUri}');
                  },
                ),
              ),
              TextFieldWidget(
                labelText: 'كلمة المرور',
                secureText: secureText,
                onChanged: (v) => password = v,
                suffixIcon: IconButton(
                  icon: Icon(
                    secureText ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xff20C3BA),
                  ),
                  onPressed: () {
                    setState(() {
                      secureText = !secureText;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: mediaQuery.width * 0.11),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MobileRegisterScreen(
                            title: 'إستعادة كلمة المرور',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'هل نسيت كلمة المرور؟',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.03,
              ),

              RegisterButton(
                title: 'تسجيل الدخول',
                onPressed: () async {
                  // await login.loginUser(context, phone, password);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (c) => TabScreen(
                        type: type,
                      ),
                    ),
                    (r) => false,
                  );
                },
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 25),
                width: mediaQuery.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                    Text(
                      'أو',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.01,
              ),
              InkWell(
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MobileRegisterScreen(
                        title: register,
                      ),
                    ),
                  ),
                  Provider.of<SignupProvider>(context, listen: false).type =
                      type,
                },
                child: Center(
                  child: Text(
                    register,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.01,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 25),
                width: mediaQuery.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                    Text(
                      'أو',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                  ],
                ),
              ),
              RegisterButton(
                title: type == 0 ? 'دخول كمزود خدمة' : 'دخول كعميل',
                onPressed: () async {
                  setState(() {
                    type = type == 0 ? 1 : 0;
                  });
                  // await login.loginUser(context, phone, password);
                },
              ),
              // RegisterButton(
              //   color: Color(0xff272D45),
              //   title: 'مستخدم جديد',
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (ctx) => ChooseRegisterTypeScreen(),
              //     ));
              //   },
              // ),
              //
              //
              //
              // SizedBox(
              //   height: mediaQuery.height * 0.01,
              // ),

              // Text(
              //   'لو لم يكن لديك حساب',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 15,
              //   ),
              // ),
              // //   Text(
              // //   'لو لم يكن لديك حساب ',
              // //   style: TextStyle(
              // //     color: Colors.black,
              // //     fontSize: 20,
              // //   ),
              // // ),
              // RichText(
              //   textAlign: TextAlign.center,
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'يمكنك التسجيل',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       TextSpan(
              //         text: ' من هنا',
              //         style: TextStyle(
              //           color: Color(0xff20C3BA),
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold,
              //         ),
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () => Navigator.of(context).push(
              //                 MaterialPageRoute(
              //                   builder: (ctx) => ChooseRegisterTypeScreen(),
              //                 ),
              //               ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
