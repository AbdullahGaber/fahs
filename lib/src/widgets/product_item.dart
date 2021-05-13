import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productSection;
  final int productPrice;
  final Function onTap;
  final Function onEdit;
  final Function onDelete;
  final bool isProvider;
  ProductItem({
    @required this.productName,
    @required this.productImage,
    @required this.productSection,
    @required this.productPrice,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.isProvider = false,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: mediaQuery.height * 0.12,
            margin: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(
                  0.3,
                ),
              ),
              // color: Colors.black12,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                bottomLeft: Radius.circular(9),
                topRight: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
            ),
          ),
          Positioned(
            top: mediaQuery.height * 0.0,
            right: mediaQuery.height * 0.11,
            child: Container(
              // height: mediaQuery.height * 0.12,
              width: mediaQuery.width,
              child: ListTile(
                title: Text(
                  productName,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  productSection,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              right: mediaQuery.height * 0.01,
              child: Container(
                height: mediaQuery.height * 0.1,
                width: mediaQuery.width * 0.18,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      productImage,
                    ),
                    fit: BoxFit.fill,
                  ),
                  // color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(9),
                ),
              )),
          Positioned(
            top: mediaQuery.height * 0.067,
            left: mediaQuery.width * 0.07,
            child: Container(
              child: Text(
                'SR ${productPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Color(0xffA4BE25),
                ),
              ),
            ),
          ),
          Positioned(
              top: mediaQuery.height * 0.015,
              left: mediaQuery.width * 0.03,
              child: Visibility(
                visible: isProvider,
                child: Row(
                  children: [
                    Container(
                        width: mediaQuery.width * 0.10,
                        child: GestureDetector(
                          onTap: onEdit,
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffA4BE25),
                            type: MaterialType.button,
                            elevation: 5,
                            child: Center(
                              child: Text(
                                'تعديل',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: mediaQuery.width * 0.02,
                    ),
                    Container(
                        width: mediaQuery.width * 0.10,
                        child: GestureDetector(
                          onTap: onDelete,
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).errorColor,
                            type: MaterialType.button,
                            child: Center(
                              child: Text(
                                'حذف',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )),
          Positioned(
            right: mediaQuery.width * 0.002,
            child: Container(
              width: mediaQuery.width * 0.006,
              height: mediaQuery.height * 0.03,
              color: Color(0xffA4BE25),
            ),
          ),
        ],
      ),
    );
  }
}
