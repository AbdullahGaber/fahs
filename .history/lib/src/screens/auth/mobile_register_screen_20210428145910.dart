import 'package:country_code_picker/country_code_picker.dart';
import 'package:fahs/src/screens/auth/confirm_phone_screen.dart';
import 'package:fahs/src/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/providers/auth/mobile_register_provider.dart';
import '../../logic/providers/auth/phone_verfication_provider.dart';
import '../../logic/providers/auth/reset_password_phone_provider.dart';
import '../../logic/providers/auth/reset_password_provider.dart';
import '../../logic/providers/auth/reset_password_verfication_provider.dart';
import '../../logic/providers/auth/signup_provider.dart';
// import '../../providers/auth/register_mobile_provider.dart';
// import '../../providers/auth/reset_password_provider.dart';
// import '../../providers/auth/confirm_reset_provider.dart';

import '../../widgets/text_field_widget.dart';
// import '../../config.dart';
// import 'package:homemade_user/providers/auth/phoneVerificationProvider.dart';

import '../../widgets/register_button.dart';
// import '../../providers/auth/forget_password_provider.dart';
// import '../../providers/changeData/change_phone_provider.dart';
// import '../../providers/auth/signup_provider.dart';

class MobileRegisterScreen extends StatefulWidget {
  final String title;

  MobileRegisterScreen({
    this.title = 'تسجيل جديد',
  });

  @override
  _MobileRegisterScreenState createState() => _MobileRegisterScreenState();
}

class _MobileRegisterScreenState extends State<MobileRegisterScreen> {
  var controller = TextEditingController();
  var phoneNumber = '';
  var code = '+966';

  var isRegister = false;
  var key = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var register = Provider.of<MobileRegisterProvider>(context, listen: false);
    var forget = Provider.of<ResetPasswordPhoneProvider>(context);
    var confirm = Provider.of<ResetPasswordVerficationProvider>(context);
    var reset = Provider.of<ResetPasswordProvider>(context);
    var number = Provider.of<SignupProvider>(context, listen: false);
    var verficate =
        Provider.of<PhoneVerficationProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(mediaQuery.height * 0.2),
            child: CustomAppBar(
              title: widget.title,
              centerTitle: true,
            ),
          ),
          body: SingleChildScrollView(
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
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'من فضلك قم بإدخال رقم جوالك ليصلك كود التفعيل',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFieldWidget(
                    suffixIcon: CountryCodePicker(
                      showFlag: false,
                      countryFilter: ['SA', 'EG'],
                      initialSelection: '',
                      onChanged: (c) {
                        code = c.dialCode;
                      },
                    ),
                    hintText: 'رقم الجوال',
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                      if (widget.title != 'إستعادة كلمة المرور') {
                        register.phone = code + value;
                        number.phone = code + value;
                        phoneNumber = code + value;
                        verficate.phone = code + value;
                      } else {
                        confirm.phone = code + value;
                        forget.phone = code + value;
                        reset.phone = code + value;
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                RegisterButton(
                  title: 'التالي',
                  onPressed: phoneNumber.isEmpty
                      ? null
                      : () async {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (c) => ConfirmPhoneScreen(
                                stateOfVerificationCode:
                                    widget.title != 'إستعادة كلمة المرور'
                                        ? 1
                                        : 2,
                              ),
                            ),
                          );
                          // if (widget.title != 'تسجيل جديد') {
                          //   forget.forgetPassword(context);
                          // } else {
                          //   await register.registerPhone(context);
                          // }
                          // print('sssssss');
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
