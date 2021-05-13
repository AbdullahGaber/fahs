import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/chat/create_chat_model.dart';

class CreateChatProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();

  Future<CreateChatModel> startChat(
    BuildContext context, {
    int providerId,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    Map<String, dynamic> map = {
      'provider_id': providerId,
    };
    Response response = await _util.post(
      'start-chat',
      headers: headers,
      context: context,
      body: FormData.fromMap(map),
    );
    if (response == null) {
      return null;
    }
    return CreateChatModel.fromJson(response.data);
  }
}
