import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../models/general/terms_model.dart';
import '../../../helper/networkUtlis.dart';

class TermsProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  String terms;
  Future<void> getTerms() async {
    Response response = await _util.get(
      'terms-and-conditions',
    );
    if (response == null) {
      terms = 'يرجى التحقق من الاتصال بالانترنت';
      return;
    }
    var model = TermsModel.fromJson(response.data);
    if (response.statusCode == 200) {
      terms = model.data[0].content;
      
    }

  }
}
