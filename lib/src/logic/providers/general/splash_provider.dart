import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/general/splash_model.dart';

class SplashProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  Future<SplashsModel> getSplashs() async {
    Response response = await _util.get(
      'splashs',
    );
    if (response == null) {
      return null;
    }
    return SplashsModel.fromJson(response.data);
  }
}
