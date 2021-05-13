import 'dart:io';
import 'package:cars_check_up/src/logic/models/user/favourites/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helper/networkUtlis.dart';
import '../../../models/user/favourites/myFavourites/my_favourite_product_model.dart';
import '../../../../widgets/custom_new_dialog.dart';
import '../../../../widgets/custom_progress_dialog.dart';

class MyFavouriteProductProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;
  ProgressDialog _pr;
  List<Datum> _myFavouriteProducts = [];
  List<Datum> get myFavouriteProducts => [..._myFavouriteProducts];
  Future<MyFavouriteProductModel> getMyFavouriteProducts(
      BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Response response = await _util.get(
      'get-favourite-products',
      context: context,
      headers: headers,
    );
    if (response == null) {
      return null;
    }
    var model = MyFavouriteProductModel.fromJson(response.data);
    if (response.statusCode == 200) {
      _myFavouriteProducts =
          model.data.where((element) => !element.providerBlocked).toList();
    }
    return MyFavouriteProductModel.fromJson(response.data);
  }

  Future<bool> addToFavourite(
    BuildContext context, {
    int productId,
    int providerId,
    bool isFromSearch = false,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      pr: _pr,
      context: context,
    );
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'product_id': productId,
    };
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'favourite-product',
      context: context,
      headers: headers,
      body: FormData.fromMap(map),
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        btnOnPress: () {},
        msg: 'يرجى التحقق من الاتصال بالانترنت',
      );
      return false;
    }
    var model = FavouriteModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);

      await getMyFavouriteProducts(context);
      return true;
    } else {
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        btnOnPress: () {},
        context: context,
      );
      return false;
    }
  }

  Future<bool> removeFromFavourite(
    BuildContext context, {
    int productId,
    int providerId,
    bool isFromSearch = false,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      pr: _pr,
      context: context,
    );
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'product_id': productId,
    };
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'unfavourite-product',
      context: context,
      headers: headers,
      body: FormData.fromMap(map),
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        btnOnPress: () {},
        msg: 'يرجى التحقق من الاتصال بالانترنت',
      );
      return false;
    }
    var model = FavouriteModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);

      if (_myFavouriteProducts.isNotEmpty) {
        var index = _myFavouriteProducts
            .indexWhere((element) => element.id == productId);
        _myFavouriteProducts.removeAt(index);
        notifyListeners();
      }

      return true;
    } else {
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        btnOnPress: () {},
        context: context,
      );
      return false;
    }
  }
}
