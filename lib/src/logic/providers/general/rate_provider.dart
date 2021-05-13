// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import '../../../helper/networkUtlis.dart';
// import '../../models/general/rate_model.dart';
// import '../../../widgets/custom_new_dialog.dart';
// import '../../../widgets/custom_progress_dialog.dart';

// class RateProvider with ChangeNotifier {
//   NetworkUtil _util = NetworkUtil();
//   SharedPreferences _prefs;
//   ProgressDialog _pr;
//   CustomProgressDialog _customProgressDialog;
//   CustomDialog _dialog = CustomDialog();

//   Future<void> rate(
//     BuildContext context, {
//     int orderId,
//     int toUserId,
//     int rate,
//   }) async {
//     _prefs = await SharedPreferences.getInstance();
//     _pr = ProgressDialog(context);
//     _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
//     String token = _prefs.get('token');
//   }
// }
