import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../helper/networkUtlis.dart';
import '../../../widgets/custom_new_dialog.dart';

class ResendCodeProvider with ChangeNotifier {
  CustomDialog _dialog = CustomDialog();
  NetworkUtil _util = NetworkUtil();
  String phone;
  Future<void> resendCode(BuildContext context) async {
    FormData data = FormData.fromMap({
      'phone_number': phone,
    });
    Response response = await _util.post(
      'resend-code',
      body: data,
    );
    if(response==null){
           await _dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: 'يرجى التحقق من الاتصال بالإنترنت',
      );
      return;
    }
  }
}
