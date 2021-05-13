import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/general/histories_model.dart';

class HistoriesProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  List<Datum> _histories = [];
  List<Datum> get histories => [..._histories];

  Future<HistoriesModel> getMyHistories(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Response response = await _util.get(
      'histories',
      headers: headers,
      context: context,
    );
    if (response == null) {
      return null;
    }
    var model = HistoriesModel.fromJson(response.data);

    if (response.statusCode == 200) {
      _histories = model.data;
    }
    return HistoriesModel.fromJson(response.data);
  }
}
