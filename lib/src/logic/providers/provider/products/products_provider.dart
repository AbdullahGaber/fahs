import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../helper/networkUtlis.dart';
import '../../../models/provider/products/add_product_model.dart';
import '../../../models/provider/products/products_model.dart';
import '../../../../widgets/custom_new_dialog.dart';
import '../../../../widgets/custom_progress_dialog.dart';

class ProductsProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;
  ProgressDialog _pr;
  List<dynamic> propertyValues = [];
  List<Datum> _myProducts = [];
  List<Datum> get myProducts => [..._myProducts];

  Future<void> addProduct(
    BuildContext context, {
    String productName,
    String price,
    int categoryId,
    String details,
    List<File> images,
  }) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      context: context,
      pr: _pr,
    );

    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'name': productName,
      'price': price,
      'category_id': categoryId,
      'details': details,
    };
    if (images.isNotEmpty) {
      for (var i = 0; i < images.length; i++) {
        map.addAll({
          'image[$i]': await MultipartFile.fromFile(images[i].path),
        });
      }
    }
    if (propertyValues.isNotEmpty) {
      for (var i = 0; i < propertyValues.length; i++) {
        map.addAll({
          'property_value_id[$i]': propertyValues[i],
        });
      }
    }
    FormData data = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'add-product',
      context: context,
      headers: headers,
      body: data,
    );
    propertyValues = [];
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
      );
      return;
    }
    var model = AddProductModel.fromJson(response.data);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      Navigator.of(context).pop();
    } else {
      await _dialog.showWarningDialog(
        context: context,
        msg: model.error[0].value,
        btnOnPress: () {},
      );
      return;
    }
  }

  Future<void> editProduct(
    BuildContext context, {
    String productName,
    int productId,
    String price,
    // int categoryId,
    String details,
    List<File> images,
  }) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      context: context,
      pr: _pr,
    );

    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      // 'category_id': categoryId,
    };
    if (productName.isNotEmpty) {
      map.addAll({
        'name': productName,
      });
    }

    if (details.isNotEmpty) {
      map.addAll({
        'details': details,
      });
    }
    if (price.isNotEmpty) {
      map.addAll({
        'price': price,
      });
    }
    if (images.isNotEmpty) {
      for (var i = 0; i < images.length; i++) {
        map.addAll({
          'image[$i]': await MultipartFile.fromFile(images[i].path),
        });
      }
    }
    if (propertyValues.isNotEmpty) {
      for (var i = 0; i < propertyValues.length; i++) {
        map.addAll({
          'property_value_id[$i]': propertyValues[i],
        });
      }
    }
    FormData data = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'update-product/$productId',
      context: context,
      headers: headers,
      body: data,
    );
    propertyValues = [];
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
      );
      return;
    }
    var model = AddProductModel.fromJson(response.data);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      await getMyProducts(context);
      Navigator.of(context).pop();
    } else {
      await _dialog.showWarningDialog(
        context: context,
        msg: model.error[0].value,
        btnOnPress: () {},
      );
      return;
    }
  }

  Future<ProductsModel> getMyProducts(
    BuildContext context,
  ) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Response response = await _util.get(
      'my-products',
      context: context,
      headers: headers,
    );
    if (response == null) {
      return null;
    }
    var model = ProductsModel.fromJson(response.data);
    if (response.statusCode == 200) {
      print(model.data.length);
      _myProducts = model.data;
      notifyListeners();
    }
    return ProductsModel.fromJson(response.data);
  }

  List<PropertyValue> getSpecificProperty({Datum myProduct, int propertyId}) =>
      myProduct.propertyValues
          .where((element) => element.propertyId == propertyId)
          .toList();

  Future<void> deleteProduct(
    BuildContext context, {
    int productId,
  }) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    _prefs = await SharedPreferences.getInstance();
    var productIndex =
        _myProducts.indexWhere((element) => element.id == productId);
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'delete-product/$productId',
      context: context,
      headers: headers,
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      Fluttertoast.showToast(msg: 'يرجى التحقق من الاتصال بالانترنت');
      return null;
    }
    var model = AddProductModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      _myProducts.removeAt(productIndex);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: model.error[0].value);
    }
  }

  Future<bool> deleteProductImageById(
    BuildContext context, {
    int productId,
    int imageId,
  }) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    _prefs = await SharedPreferences.getInstance();
    var productIndex =
        _myProducts.indexWhere((element) => element.id == productId);
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'delete-prodcut-image-by-id/$imageId',
      context: context,
      headers: headers,
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      Fluttertoast.showToast(msg: 'يرجى التحقق من الاتصال بالانترنت');
      return false;
    }
    var model = AddProductModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      _myProducts[productIndex]
          .images
          .removeWhere((element) => element.id == imageId);
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: model.error[0].value);
      return false;
    }
  }
}
