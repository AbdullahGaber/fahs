import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/provider/property_model.dart';

class PropertyProvider with ChangeNotifier {
  List<Datum> _myProperties = [];
  List<Datum> get myProperties => [..._myProperties];
  NetworkUtil _util = NetworkUtil();

  Future<void> getMyProperties({String sectionId}) async {
    Response response = await _util.get(
      sectionId == null ? 'properties' : 'properties/$sectionId',
    );
    if (response == null) {
      return;
    }
    var model = PropertyModel.fromJson(response.data);
    if (response.statusCode == 200) {
      _myProperties = model.data;
      notifyListeners();
    }
  }

  Datum findPropertyById({int id}) {
    return _myProperties.isEmpty
        ? Datum(
            id: 2,
            name: 'ddd',
            values: {},
          )
        : _myProperties.firstWhere((element) => element.id == id);
  }
}
