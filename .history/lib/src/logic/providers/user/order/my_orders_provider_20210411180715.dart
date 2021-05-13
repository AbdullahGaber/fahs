import 'dart:io';
import 'package:cars_check_up/src/logic/models/provider/order/complete_order_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../../helper/networkUtlis.dart';
import '../../../models/user/order/my_orders_model.dart';
import '../../../../widgets/custom_new_dialog.dart';
import '../../../../widgets/custom_progress_dialog.dart';

class MyOrdersProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  List<Datum> _myOrders = [];
  List<Datum> get myOrders => [..._myOrders];
  Future<MyOrdersModel> getMyOrders(
    BuildContext context,
  ) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    String type = _prefs.get('type');
    print('token: $token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Response response = await _util.get(
      type == 'عميل' ? 'my-orders' : 'provider-orders',
      headers: headers,
      context: context,
    );
    print('sss');
    print(response.statusCode);
    if (response == null) {
      return null;
    }
    print('sss');

    var model = MyOrdersModel.fromJson(response.data);
    if (response.statusCode == 200) {
      print('sss');
      print('sss');
      print('sss');
      _myOrders = model.data;
      notifyListeners();
    }
    return MyOrdersModel.fromJson(response.data);
  }

  int activeOrderCount() {
    int count = 0;
    if (_myOrders.isNotEmpty) {
      for (var i = 0; i < _myOrders.length; i++) {
        if (_myOrders[i].status == 'نشط') {
          count++;
        }
      }
    }
    return count;
  }

  List<Datum> specificOrder(
    String orderStatus,
  ) {
    return _myOrders.isEmpty
        ? []
        : _myOrders
            .where(
              (element) => element.status.contains(orderStatus),
            )
            .toList();
  }

  // provider ....
  CustomProgressDialog _customProgressDialog;
  ProgressDialog _pr;
  CustomDialog _dialog = CustomDialog();

  Future<void> completeOrder(
    BuildContext context, {
    int orderId,
    String notes,
  }) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      context: context,
      pr: _pr,
    );
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'order_id': orderId,
    };
    if (notes != null) {
      map.addAll({
        'notes': notes,
      });
    }
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      notes == null ? 'compelete-order' : 'cancele-order',
      context: context,
      headers: headers,
      body: FormData.fromMap(map),
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        btnOnPress: () {},
        msg: 'يرجى التحقق من الاتصال بالانترنت',
      );
      return;
    }
    var model = CompleteOrderModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      await getMyOrders(context);
      if (notes != null) {
        Navigator.of(context).pop();
      } else {
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //       builder: (c) => TabScreen(
        //             index: 0,
        //             type: 1,
        //           )),
        //   (route) => false,
        // );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (c) => CommissionsScreen(),
        //   ),
        // );
      }
    } else {
      await _dialog.showWarningDialog(
        context: context,
        msg: model.error[0].value,
        btnOnPress: () {},
      );
    }
  }

  int getOrderCount({String status}) {
    int count = 0;
    if (specificOrder(status).isNotEmpty) {
      for (var i = 0; i < specificOrder(status).length; i++) {
        count++;
      }
    }
    return count;
  }
}
