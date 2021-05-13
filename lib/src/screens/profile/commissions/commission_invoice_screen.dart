import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helper/image_picker_dialog.dart';
import './widgets/invoice_image_widget.dart';
import '../../../widgets/register_button.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../logic/models/provider/order/commissions_model.dart';
import '../../../logic/providers/provider/order/commissions_provider.dart';

class CommissionInvoiceScreen extends StatefulWidget {
  final Datum commission;
  CommissionInvoiceScreen({
    @required this.commission,
  });
  @override
  _CommissionInvoiceScreenState createState() =>
      _CommissionInvoiceScreenState();
}

class _CommissionInvoiceScreenState extends State<CommissionInvoiceScreen> {
  File pickedInvoice;
  bool isInit = true;
  CommissionsProvider commissionsProvider;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      commissionsProvider =
          Provider.of<CommissionsProvider>(context, listen: false);
      if (widget.commission.paymentImage.isEmpty) {
        Future.delayed(
            Duration(
              microseconds: 2,
            ), () {
          ImagePickerDialog().show(
            context: context,
            onGet: (image) => setState(
              () => pickedInvoice = image,
            ),
          );
        });
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/background.jpg',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: Color(0xffA4BE25),
              ),
              onPressed: () => ImagePickerDialog().show(
                context: context,
                onGet: (image) => setState(
                  () => pickedInvoice = image,
                ),
              ),
            ),
          ],
          title: Text(
            'إرسال فاتورة الدفع',
          ),
          centerTitle: true,
        ),
        body: Visibility(
          visible: pickedInvoice != null ||
              widget.commission.paymentImage.isNotEmpty,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Column(
                children: [
                  InvoiceImageWidget(
                    imageUrl: widget.commission.paymentImage,
                    showNetworkImage:
                        widget.commission.paymentImage.isNotEmpty &&
                            pickedInvoice == null,
                    onDelete: () => setState(
                      () => pickedInvoice = null,
                    ),
                    fileImage: pickedInvoice,
                  ),
                  RegisterButton(
                      title: 'إرسال',
                      onPressed: () async {
                        var dialog = CustomDialog();
                        await dialog.showOptionDialog(
                          msg: widget.commission.paymentImage.isEmpty
                              ? 'سيتم إرسال صورة فاتورة الدفع , هل أنت متأكد؟'
                              : 'سيتم تغيير صورة الفاتورة الحالية , هل أنت متأكد؟',
                          okMsg: 'نعم',
                          cancelMsg: 'لا',
                          context: context,
                          okFun: () async {
                            await commissionsProvider.uploadCommissionImage(
                              context,
                              image: pickedInvoice,
                              orderId: widget.commission.id,
                            );
                          },
                          cancelFun: () {
                            return;
                          },
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
