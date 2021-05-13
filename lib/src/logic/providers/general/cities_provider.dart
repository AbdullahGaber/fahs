import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../models/general/cities_model.dart';
import '../../../helper/networkUtlis.dart';

class CitiesProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  List<Datum> myCities = [];
  Future<void> getCities({int regionId}) async {
    Response response = await _util.get(
      regionId == null ? 'cities' : 'cities/$regionId',
    );
    if (response == null) {
      return;
    }
    var model = CitiesModel.fromJson(response.data);
    if (response.statusCode == 200) {
      myCities = model.data;
      notifyListeners();
    }
  }
}
