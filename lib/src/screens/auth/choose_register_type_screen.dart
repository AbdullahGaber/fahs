import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './mobile_register_screen.dart';
import '../../logic/providers/auth/signup_provider.dart';
import '../../widgets/register_button.dart';
import '../../widgets/title_bar_widget.dart';

class ChooseRegisterTypeScreen extends StatefulWidget {
  @override
  _ChooseRegisterTypeScreenState createState() =>
      _ChooseRegisterTypeScreenState();
}

class _ChooseRegisterTypeScreenState extends State<ChooseRegisterTypeScreen> {
  bool isInit = true;
  SignupProvider signupProvider;
  @override
  void didChangeDependencies() {
    if (isInit) {
      signupProvider = Provider.of<SignupProvider>(context, listen: false);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff20C3BA),
            Color(0xff4CCA93),
            Color(0xff5CCC85),
            Color(0xff98D651),
            Color(0xffA7D943),
            Color(0xffCADF24),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: mediaQuery.height * 0.06,
            ),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/icon004.png',
                height: mediaQuery.height * 0.25,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  RegisterButton(
                    // color: Color(0xffA4BE25),
                    title: 'تسجيل كزبون',
                    textColor: Colors.black,
                    color: Colors.white,
                    onPressed: () {
                      signupProvider.type = 0;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (ctx) => MobileRegisterScreen()),
                      );
                    },
                  ),
                  RegisterButton(
                    showBorder: true,
                    title: 'تسجيل كمزود خدمة',
                    textColor: Colors.black,
                    onPressed: () {
                      signupProvider.type = 1;

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (ctx) => MobileRegisterScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
