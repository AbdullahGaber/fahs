import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/general/search_model.dart';
import '../../../helper/networkUtlis.dart';

class SearchProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  SearchModel _model;

  int minQuantity;
  String _errorMessage;
  String get errorMessage => _errorMessage;

  Future<SearchModel> search({
    String keyword,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> map = {
      'keyword': keyword,
    };
    if (_prefs.containsKey('id')) {
      map.addAll({
        'user_id': _prefs.get('id'),
      });
    }
    FormData data = FormData.fromMap(map);
    Response response = await _util.post(
      'search',
      body: data,
    );
    if (response == null) {
      return null;
    }
    _model = SearchModel.fromJson(response.data);
    if (response.statusCode == 200) {
      if (_model.data.isNotEmpty) {
        for (var i = 0; i < _model.data.length; i++) {
          var prod = _model.data
              .where(
                (element) => element.providerId == _model.data[i].providerId,
              )
              .toList();

          notifyListeners();
        }

        _errorMessage = null;
        notifyListeners();
        return SearchModel.fromJson(response.data);
      } else {
        _errorMessage = _model.error[0].value;

        notifyListeners();
        return SearchModel.fromJson(response.data);
      }
    }
  }
}
