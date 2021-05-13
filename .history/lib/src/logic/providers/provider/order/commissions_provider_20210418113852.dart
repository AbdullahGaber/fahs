import 'dart:io';
import 'package:fahs/src/logic/models/provider/order/commisssions_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../helper/networkUtlis.dart';
import '../../../models/provider/order/commissions_model.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../../widgets/custom_new_dialog.dart';
import '../../../../widgets/custom_progress_dialog.dart';

class CommissionsProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  List<Datum> _myCommissions = [];
  List<Datum> get myCommissions => [..._myCommissions];

  Future<CommissionsModel> getMyCommissions(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Response response =
        await _util.get('provider-orders', headers: headers, context: context);
    if (response == null) {
      return null;
    }
    var model = CommissionsModel.fromJson(response.data);
    if (response.statusCode == 200) {
      _myCommissions = model.data;
      notifyListeners();
    }
    return CommissionsModel.fromJson(response.data);
  }

  int unPayedCommission() {
    int count = 0;
    if (_myCommissions.isNotEmpty) {
      for (var i = 0; i < _myCommissions.length; i++) {
        if (_myCommissions[i].paymentStatus == 0 &&
            _myCommissions[i].status == 'مكتمل') {
          count++;
        }
      }
    }
    return count;
  }

  List<Datum> findSpecificCommissions({bool payedCommissions}) =>
      _myCommissions.isEmpty
          ? []
          : _myCommissions
              .where(
                (element) => payedCommissions
                    ? element.paymentStatus == 1
                    : element.paymentStatus == 0,
              )
              .toList();

  int getPayedAmount({bool payed}) {
    int price = 0;
    if (findSpecificCommissions(payedCommissions: payed).isNotEmpty) {
      for (var i = 0;
          i < findSpecificCommissions(payedCommissions: payed).length;
          i++) {
        price += findSpecificCommissions(payedCommissions: payed)[i].tax;
      }
    }

    return price;
  }

  Future<void> uploadCommissionImage(BuildContext context,
      {File image, int orderId}) async {
    var pr = ProgressDialog(context);
    var cpDialog = CustomProgressDialog(context: context, pr: pr);
    var dialog = CustomDialog();
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'order_id': orderId,
      'payment_image': await MultipartFile.fromFile(image.path),
    };
    cpDialog.showProgressDialog();
    cpDialog.showPr();

    Response response = await _util.post(
      'upload-payment-image',
      headers: headers,
      context: context,
      body: FormData.fromMap(map),
    );
    await cpDialog.hidePr();
    if (response == null) {
      await dialog.showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
        context: context,
      );
      return null;
    }
    var model = CommissionsPaymentModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      await getMyCommissions(context);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
        msg: model.error[0].value,
        backgroundColor: Colors.red,
      );
    }
  }
}
