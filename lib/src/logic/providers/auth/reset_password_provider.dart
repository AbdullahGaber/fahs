import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
// import 'package:t3myrkm/src/screens/auth/login_screen.dart';
import '../../models/auth/mobile_register_model.dart';
import '../../../helper/networkUtlis.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ResetPasswordProvider with ChangeNotifier {
  ProgressDialog _pr;
  CustomProgressDialog _customProgressDialog;
  CustomDialog _dialog = CustomDialog();
  NetworkUtil _util = NetworkUtil();
  String phone;
  String password;
  String confirmPassword;
  Future<void> resetPassword(BuildContext context) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    Map<String, dynamic> map = {
      'phone_number': phone,
      'password': password,
      'password_confirmation': confirmPassword,
    };
    FormData formData = FormData.fromMap(map);

    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'user-reset-password',
      body: formData,
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        context: context,
        btnOnPress: () {},
      );
      return;
    }
    var model = MobileRegisterModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: model.data,
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          // builder: (c) => LoginScreen(),
        ),
        (route) => false,
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
