import 'dart:io';
import 'package:fahs/src/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
// import 'package:t3myrkm/src/screens/tab_screen.dart';
import '../../../models/user/order/post_order_model.dart';
import '../../../../helper/networkUtlis.dart';
import '../../../../widgets/custom_new_dialog.dart';
import '../../../../widgets/custom_progress_dialog.dart';

class PostOrderProvider with ChangeNotifier {
  ProgressDialog _pr;
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;

  Future<void> postOrder(
    BuildContext context, {
    List<int> propertyValue,
    String recievePlace,
    int price,
    int quantity,
    int providerId,
    int productId,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    String apiToken = _prefs.get('token');
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(pr: _pr, context: context);

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $apiToken',
    };
    Map<String, dynamic> map = {
      'price': price,
      'count': quantity,
      'provider_id': providerId,
      'product_id': productId,
      'recieve_place': recievePlace,
    };
    if (propertyValue.isNotEmpty) {
      for (var i = 0; i < propertyValue.length; i++) {
        map.addAll(
          {
            'property_values[$i]': propertyValue[i],
          },
        );
      }
    }
    FormData data = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'order',
      context: context,
      headers: headers,
      body: data,
    );
    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        btnOnPress: () {},
        msg: 'يرجى التحقق من الاتصال بالانترنت',
      );
      return;
    }
    var model = PostOrderModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (c) => TabScreen(
            index: 2,
            type: 0,
          ),
        ),
        (route) => false,
      );
    } else {
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        btnOnPress: () {},
        context: context,
      );
      return;
    }
  }
}
