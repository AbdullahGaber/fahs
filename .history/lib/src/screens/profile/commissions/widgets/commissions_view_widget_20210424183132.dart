import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
// import 'package:t3myrkm/src/logic/providers/provider/order/commissions_provider.dart';
import './commission_card.dart';
import '../../../../logic/models/provider/order/commissions_model.dart';
import '../commission_invoice_screen.dart';

class CommissionsViewWidget extends StatelessWidget {
  final List<Notification> myCommissions;
  final bool payedCommissions;
  CommissionsViewWidget({this.myCommissions, this.payedCommissions});
  @override
  Widget build(BuildContext context) {
    return myCommissions.isEmpty
        ? Center(
            child: Text(
              'لا يوجد بيانات حاليا',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: myCommissions.length,
                  itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                    position: i,
                    delay: Duration(milliseconds: 400),
                    child: SlideAnimation(
                      duration: Duration(milliseconds: 400),
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: InkWell(
                          // onTap: myCommissions[i].paymentStatus == 1
                          //     ? null
                          //     : () {
                          //         Navigator.of(context).push(
                          //           MaterialPageRoute(
                          //             builder: (c) => CommissionInvoiceScreen(
                          //               // commission: myCommissions[i],
                          //             ),
                          //           ),
                          //         );
                          //       },
                          child: CommissionsCard(
                           
                            createdAt:
                                myCommissions[i].createdAt.toString().substring(0, 10),
                            price: '145',
                            title:
                                'طلب رقم  ${myCommissions[i].id} للعميل ${myCommissions[i].userName}',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<CommissionsProvider>(
                builder: (_, snap, __) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      'إجمالي العمولات : ${snap.getPayedAmount(payed: payedCommissions)} ريال',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }
}
class Notification {
  final String title;

  final String message;
  final String setTitle;

  final DateTime createdAt;

  Notification(this.title, this.message, this.createdAt,
      {this.setTitle = "العنوان"});
}