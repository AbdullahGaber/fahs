import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/auth/phone_verfication_model.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';
// import '../../../screens/auth/signup_screen.dart';

class PhoneVerficationProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  ProgressDialog _pr;
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog = CustomProgressDialog();
  String phone;
  String code;
  Future<void> verficatePhone(BuildContext context) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);

    FormData data = FormData.fromMap({
      'phone_number': phone,
      'code': code,
    });
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'phone-verification',
      body: data,
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
      );
      return;
    }
    var model = PhoneVerficationModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // builder: (c) => SignupScreen(),
        ),
      );
    } else {
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        context: context,
        btnOnPress: () {},
      );
    }
  }
}
