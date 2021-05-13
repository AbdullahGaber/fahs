import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../../../helper/networkUtlis.dart';
import '../../../models/general/notifications/notifications_model.dart';
import '../../../../widgets/custom_progress_dialog.dart';

class NotificationsProvider with ChangeNotifier {
  List<Datum> _myNotifications = [];
  int _unReadNotifications = 0;
  List<Datum> get myNotification => [..._myNotifications];
  int get unReadNotification {
    int num = 0;
    _myNotifications.forEach((element) {
      if (element.isRead == 0) {
        num++;
      }
    });
    _unReadNotifications = num;

    return _unReadNotifications;
  }
  disposeNotifications(){

  _unReadNotifications = 0;
  }

  NetworkUtil _util = NetworkUtil();
  SharedPreferences _prefs;
  CustomProgressDialog _customProgressDialog;
  ProgressDialog _pr;
  Future<NotificationsModel> getNotifications(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String apiToken = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $apiToken',
    };
    Response response = await _util.get(
      'list-notifications',
      context: context,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var model = NotificationsModel.fromJson(response.data);
      _myNotifications = model.data;
      notifyListeners();
    }
    return NotificationsModel.fromJson(response.data);
  }

  Future<void> readAllNotifications() async {
    _prefs = await SharedPreferences.getInstance();
    String apiToken = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $apiToken',
    };
    Response response =
        await _util.post('read_all_Notifications', headers: headers);

    if (response.statusCode == 200) {
      _myNotifications.forEach((element) {
        element.isRead = 1;
      });
      notifyListeners();
    }
  }

  Future<bool> deleteNotification(
      int notificationId, BuildContext context) async {
    var notIndex =
        _myNotifications.indexWhere((element) => element.id == notificationId);
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    _prefs = await SharedPreferences.getInstance();
    String apiToken = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $apiToken',
    };
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post('delete_Notifications/$notificationId',
        headers: headers);
    await _customProgressDialog.hidePr();
    if (response.statusCode == 200) {
      _myNotifications.removeAt(notIndex);
      notifyListeners();
      return true;
    }
    return false;
  }
}
