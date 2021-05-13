import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../models/general/terms_model.dart';
import '../../../helper/networkUtlis.dart';

class AboutUsProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  String aboutUs;
  Future<void> getTerms() async {
    Response response = await _util.get(
      'about-us',
    );
    if (response == null) {
      aboutUs = 'يرجى التحقق من الاتصال بالانترنت';
      return;
    }
    var model = TermsModel.fromJson(response.data);
    if (response.statusCode == 200) {
      aboutUs = model.data[0].content;
    }
  }
}
