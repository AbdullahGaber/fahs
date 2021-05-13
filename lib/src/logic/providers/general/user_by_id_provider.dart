import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/general/user_model.dart';

class UserByIdProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  Future<UserModel> searchUser({int userId}) async {
    Response response = await _util.get('user/$userId');
    if (response == null) {
      return null;
    }
    return UserModel.fromJson(response.data);
  }
}
