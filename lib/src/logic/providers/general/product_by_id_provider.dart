import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../models/general/product_by_id_model.dart';
import '../../../helper/networkUtlis.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ProductByIdProvider with ChangeNotifier {
  ProgressDialog _pr;
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;
  NetworkUtil _util = NetworkUtil();
  Future<ProductByIdModel> getCertificateProduct(
    BuildContext context, {
    int productId,
  }) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      pr: _pr,
      context: context,
    );
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.get('product/$productId');
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
        context: context,
      );
      return null;
    }
    return ProductByIdModel.fromJson(response.data);
  }
}
