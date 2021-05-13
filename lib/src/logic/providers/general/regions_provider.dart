import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../models/general/regions_model.dart';
import '../../../helper/networkUtlis.dart';

class RegionsProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  List<Datum> myRegions = [];
  Future<void> getRegions() async {
    Response response = await _util.get(
      'regions',
    );
    if (response == null) {
      return;
    }
    var model = RegionsModel.fromJson(response.data);
    if (response.statusCode == 200) {
      myRegions = model.data;
      notifyListeners();
    }
  }
}
