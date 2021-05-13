import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../models/general/settings_model.dart';
import '../../../helper/networkUtlis.dart';

class SettingsProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  String email;
  String phone;
  String bankName;
  String bankNumber;
  int distance;
  double commission;
  int activeOrderCount;
  int unPaidCommission;

  Future<void> getSettings(BuildContext context) async {
    Response response = await _util.get(
      'settings',
      context: context,
    );
    if (response == null) {
      return;
    }
    var model = SettingsModel.fromJson(response.data);
    if (response.statusCode == 200) {
      var data = model.data[0];
      email = data.email;
      phone = data.phone;
      bankName = data.bankName;
      bankNumber = data.bankNumber;
      distance = data.distance;
      commission = data.commission;
      activeOrderCount = data.activeOrdersCount;
      unPaidCommission = data.unpaidCommissions;
      notifyListeners();
    }
  }
}
