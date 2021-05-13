import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/providers/auth/login_provider.dart';
import './choose_register_type_screen.dart';
import './mobile_register_screen.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/register_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool secureText = true;
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
                suffixIcon: Transform.scale(
                  scale: 0.5,
                  child: ImageIcon(
                    AssetImage(
                      'assets/icons/user.png',
                    ),
                    color: Color(0xff98D651),
                  ),
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
              // RegisterButton(
              //   color: Color(0xffA4BE25),
              //   title: 'دخول كعميل',
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (ctx) => TabScreen(),
              //     ));
              //   },
              // ),
              // RegisterButton(
              //   color: Color(0xffA4BE25),
              //   title: 'دخول كمزود خدمة',
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (ctx) => TabScreen(
              //         type: 1,
              //       ),
              //     ));
              //   },
              // ),
              RegisterButton(
                title: 'دخول',
                onPressed: () async {
                  await login.loginUser(context, phone, password);
                },
              ), RegisterButton(
                title: 'دخول',
                onPressed: () async {
                  await login.loginUser(context, phone, password);
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
              SizedBox(
                height: mediaQuery.height * 0.1,
              ),
              Text(
                'لو لم يكن لديك حساب',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              //   Text(
              //   'لو لم يكن لديك حساب ',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 20,
              //   ),
              // ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'يمكنك التسجيل',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' من هنا',
                      style: TextStyle(
                        color: Color(0xff20C3BA),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ChooseRegisterTypeScreen(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
