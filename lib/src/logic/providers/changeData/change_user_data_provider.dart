import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/changeData/change_user_data_model.dart';
import '../../../helper/networkUtlis.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ChangeUserDataProvider with ChangeNotifier {
  SharedPreferences _prefs;
  ProgressDialog _pr;
  CustomProgressDialog _customProgressDialog;
  CustomDialog _dialog = CustomDialog();
  NetworkUtil _util = NetworkUtil();
  String name;
  File image;
  String email;
  String commercialRecord;
  File commercialImage;
  int cityId;

  Future<void> changeData(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(pr: _pr, context: context);

    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {};
    if (name != null) {
      map.addAll({
        'name': name,
      });
    }
    if (image != null) {
      map.addAll({
        'image': await MultipartFile.fromFile(image.path),
      });
    }
    if (email != null) {
      map.addAll({
        'email': email,
      });
    }
    if (commercialRecord != null) {
      map.addAll({
        'commercial_record': commercialRecord,
      });
    }
    if (commercialImage != null) {
      map.addAll({
        'commercial_image': await MultipartFile.fromFile(commercialImage.path),
      });
    }
    if (cityId != null) {
      map.addAll({
        'city_id': cityId,
      });
    }
    FormData data = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post('user-change-info',
        context: context, headers: headers, body: data);
    if (response == null) {
      await _customProgressDialog.hidePr();
      await _dialog.showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
        context: context,
      );
      return;
    }
    var model = ChangeUserDataModel.fromJson(response.data);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'تم تحديث بياناتك الشخصية بنجاح');
      await _prefs.setInt('active', model.data.active);
      await _prefs.setInt('id', model.data.id);
      await _prefs.setString('name', model.data.name);
      await _prefs.setString('phone', model.data.phoneNumber);
      await _prefs.setString('email', model.data.email);
      await _prefs.setString('image', model.data.image);
      await _prefs.setString('token', model.data.apiToken);
      await _prefs.setBool('blocked', model.data.blocked);
      await _prefs.setString('type', model.data.type);
      await _prefs.setDouble('lat', model.data.latitude);
      await _prefs.setDouble('lon', model.data.longitude);
      if (_prefs.get('type') == 'مزود خدمة') {
        await _prefs.setString('city_name', model.data.cityName);
        await _prefs.setString('region_name', model.data.regionName);
        await _prefs.setInt('city_id', model.data.cityId);
        await _prefs.setInt('region_id', model.data.regionId);
        await _prefs.setString('com_image', model.data.commercialImage);
        await _prefs.setString('com_record', model.data.commercialRecord);
      }

      await _customProgressDialog.hidePr();
    } else {
      await _customProgressDialog.hidePr();
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        btnOnPress: () {},
        context: context,
      );
    }
  }
}
