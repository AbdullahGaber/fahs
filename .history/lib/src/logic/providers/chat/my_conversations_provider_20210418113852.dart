import 'dart:io';
import 'package:fahs/src/logic/models/chat/upload_chat_file_model.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/chat/conversations_model.dart' as models;
import '../../models/chat/my_conversations_model.dart';

class MyConversationsProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  List<models.Datum> _myConversationsMessages = [];
  List<models.Datum> get myConversationsMessages =>
      [..._myConversationsMessages];
  Future<models.ConversationMessagesModel> getConversationsMessages(
    BuildContext context, {
    int conversationId,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    Response response = await _util.get(
      'conversation-messages/$conversationId',
      headers: headers,
      context: context,
    );
    if (response == null) {
      return null;
    }
    var model = models.ConversationMessagesModel.fromJson(response.data);
    if (response.statusCode == 200) {
      model.data.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      _myConversationsMessages = _myConversationsMessages.reversed.toList();
      _myConversationsMessages = model.data.reversed.toList();
      notifyListeners();
    }
    return model;
  }

  addNewMessages(models.Datum message) async {
    if (_myConversationsMessages.contains(message)) {
      print('contain this message ${message.message}');
      return;
    }

    _myConversationsMessages.insert(0, message);
    notifyListeners();
  }

  changeSeenStatus() {
    if (_myConversationsMessages.isNotEmpty &&
        _myConversationsMessages.indexWhere((element) => element.seen == 0) >=
            0) {
      for (var i = 0; i < _myConversationsMessages.length; i++) {
        if (_myConversationsMessages[i].seen == 0) {
          _myConversationsMessages[i].seen = 1;
        }
      }
      notifyListeners();
    }
  }

  Future<UploadChatFileModel> uploadFile(
    BuildContext context, {
    int conversationId,
    File image,
  }) async {
    var pr = ProgressDialog(context);
    var cpDialog = CustomProgressDialog(
      context: context,
      pr: pr,
    );
    Map<String, dynamic> map = {
      'conversation_id': conversationId,
      'file': await MultipartFile.fromFile(image.path),
    };
    cpDialog.showProgressDialog();
    cpDialog.showPr();
    Response response = await _util.post(
      'upload-chat-file',
      context: context,
      body: FormData.fromMap(map),
    );
    await cpDialog.hidePr();
    if (response == null) {
      return null;
    }
    return UploadChatFileModel.fromJson(response.data);
  }

  disposeMessages() {
    _myConversationsMessages.clear();
    print(_myConversationsMessages);
  }

  // conversations

  Future<MyConversationsModel> getMyConversations(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    Response response = await _util.get(
      'my-conversations',
      headers: headers,
      context: context,
    );
    if (response == null) {
      return null;
    }

    return MyConversationsModel.fromJson(response.data);
  }
}
