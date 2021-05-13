import 'dart:io' show Platform;
import 'package:fahs/src/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import '../../logic/providers/auth/reset_password_verfication_provider.dart';
import '../../logic/providers/auth/phone_verfication_provider.dart';
import '../../logic/providers/auth/resend_code_provider.dart';
import '../../logic/providers/changeData/change_phone_verfication_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class ConfirmPhoneScreen extends StatefulWidget {
  static const String routeName = '/confirm-phone';

  final int stateOfVerificationCode;
  ConfirmPhoneScreen({
    this.stateOfVerificationCode,
  });
  @override
  _ConfirmPhoneScreenState createState() => _ConfirmPhoneScreenState();
}

class _ConfirmPhoneScreenState extends State<ConfirmPhoneScreen> {
  bool resend = false;
  int timer = 1;
  String phoneNumber = '';
  SharedPreferences prefs;

  // PhoneVerficationProvider register;
  // ResendCodeProvider confirmRessetCode;
  // ChangePhoneVerficationProvider changePhone;
  bool isInit = true;
  void _listenForCode() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      _listenForCode();
    }
    super.initState();
  }

  void dispose() {
    if (Platform.isAndroid) {
      SmsAutoFill().unregisterListener();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      prefs = await SharedPreferences.getInstance();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var register =
        Provider.of<PhoneVerficationProvider>(context, listen: false);
    var confirmRessetCode =
        Provider.of<ResetPasswordVerficationProvider>(context, listen: false);
    var changePhone =
        Provider.of<ChangePhoneVerficationProvider>(context, listen: false);

    return Container(
      child: Scaffold(
        // backgroundColor: Colors.transparent,

        // resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: mediaQuery.height * 0.4,
                    width: mediaQuery.width * 0.5,
                    decoration: BoxDecoration(),
                    child: Image.asset('assets/images/icon005.png'),
                  ),
                ),
                Center(
                    child: Text(
                  widget.stateOfVerificationCode == 1
                      ? "تسجيل جديد"
                      : widget.stateOfVerificationCode == 2
                          ? 'إستعادة كلمة المرور'
                          : 'تغيير رقم الجوال',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "ادخل كود التفعيل المرسل اليك",
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: (widget.stateOfVerificationCode == 1 &&
                          register.phone != null) ||
                      (widget.stateOfVerificationCode == 2 &&
                          confirmRessetCode.phone != null) ||
                      (widget.stateOfVerificationCode == 3 &&
                          changePhone.phone != null),
                  child: Center(
                      child: Text(
                    "تم إرسال الكود إلى ${widget.stateOfVerificationCode == 1 ? register.phone : widget.stateOfVerificationCode == 2 ? confirmRessetCode.phone : changePhone.phone}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: (resend && widget.stateOfVerificationCode != 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          child: new Text(
                            'إعادة ارسال الكود',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff20C3BA),
                              fontSize: 13,
                              fontFamily: 'cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            if (widget.stateOfVerificationCode == 1) {
                              Provider.of<ResendCodeProvider>(context,
                                      listen: false)
                                  .phone = register.phone;
                              print('sssa');
                              Provider.of<ResendCodeProvider>(context,
                                      listen: false)
                                  .resendCode(context);
                            } else if (widget.stateOfVerificationCode == 2) {
                              Provider.of<ResendCodeProvider>(context,
                                      listen: false)
                                  .phone = confirmRessetCode.phone;
                              Provider.of<ResendCodeProvider>(context,
                                      listen: false)
                                  .resendCode(context);
                            } else {
                              Provider.of<ResendCodeProvider>(context,
                                      listen: false)
                                  .phone = changePhone.phone;
                              Provider.of<ResendCodeProvider>(context,
                                      listen: false)
                                  .resendCode(context);
                            }
                            // Provider.of<ResendCodeProvider>(context,
                            //         listen: false)
                            //     .resendCode(context);
                            setState(() {
                              resend = false;
                            });
                            // resendCodeBloc.add(Click());
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'لم يصلك كود التفعيل؟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                resend == true
                    ? Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(
                            "سيصل الكود خلال",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: SlideCountdownClock(
                              duration: Duration(minutes: timer),
                              slideDirection: SlideDirection.Down,
                              tightLabel: true,
                              onDone: () {
                                setState(() {
                                  resend = true;
                                });
                              },
                              separator: ":",
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Acme',
                                color: Color(0xffA4BE25),
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                  child: PinFieldAutoFill(
                    codeLength: 4,
                    decoration: BoxLooseDecoration(
                      textStyle: TextStyle(color: Colors.black),
                      strokeColorBuilder: FixedColorBuilder(
                        Colors.white.withOpacity(0.2),
                      ),
                      bgColorBuilder: FixedColorBuilder(
                        Colors.black12,
                      ),
                    ),
                    // backgroundColor:
                    //     Color(0x00000000), //Theme.of(context).accentColor,

                    // textStyle: TextStyle(
                    //     color: Theme.of(context).primaryColor,
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: 'Acme'),
                    // cursorColor: Colors.black,
                    // inputFormatters: [blacklistingTextInputFormatter.digitsOnly],
                    // pinTheme: PinTheme(
                    //   activeColor: Theme.of(context).primaryColor,
                    //   selectedColor: Theme.of(context).accentColor,
                    //   inactiveColor: Theme.of(context).accentColor,
                    // ),
                    // onChanged: (code) {
                    //   if (widget.stateOfVerificationCode == 1)
                    //     register.code = code;
                    //   else if (widget.stateOfVerificationCode == 2)
                    //     confirmRessetCode.code = code;
                    //   else {
                    //     changePhone.code = code;
                    //   }
                    // },
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // // textInputType: TextInputType.number,
                    // autoFocus: true,
                    onCodeChanged: (String code) async {
                      if(widget.stateOfVerificationCode==1){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(c)=>SignupScreen()))
                      }
                      // if (widget.stateOfVerificationCode == 1)
                      //   register.code = code;
                      // else if (widget.stateOfVerificationCode == 2)
                      //   confirmRessetCode.code = code;
                      // else {
                      //   changePhone.code = code;
                      // }
                      // if (code.length == 4) {
                      //   FocusScope.of(context).requestFocus(FocusNode());
                      //   if (widget.stateOfVerificationCode == 1) {
                      //     await register.verficatePhone(context);
                      //   } else if (widget.stateOfVerificationCode == 2) {
                      //     await confirmRessetCode.verficatePhone(context);
                      //   } else
                      //     changePhone.phoneVerficate(
                      //       context,
                      //     );
                      // }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
