import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/providers/auth/reset_password_provider.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/register_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  final bool isResetPassword;
  ResetPasswordScreen({this.isResetPassword = true});
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool securePassword = true;
  bool secureConfirm = true;

  @override
  Widget build(BuildContext context) {
   
    var resetPasswordProvider =
        Provider.of<ResetPasswordProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
            SizedBox(
              height: mediaQuery.height * 0.05,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'تغيير كلمة المرور',
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
              labelText: 'كلمة المرور',
              secureText: securePassword,
              onChanged: (v) => resetPasswordProvider.password = v,
              suffixIcon: IconButton(
                icon: Icon(
                  securePassword ? Icons.visibility : Icons.visibility_off,
                  size: 15,
                  color: Color(0xff20C3BA),
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
              onChanged: (v) => resetPasswordProvider.confirmPassword = v,
              secureText: secureConfirm,
              suffixIcon: IconButton(
                icon: Icon(
                  secureConfirm ? Icons.visibility : Icons.visibility_off,
                  size: 15,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    secureConfirm = !secureConfirm;
                  });
                },
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.02,
            ),
            RegisterButton(
              title: 'حفظ',
              onPressed: () async {
                await resetPasswordProvider.resetPassword(
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
