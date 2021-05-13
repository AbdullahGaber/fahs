import 'dart:io';
import 'package:flutter/material.dart';

class InvoiceImageWidget extends StatelessWidget {
  const InvoiceImageWidget({
    Key key,
    @required this.onDelete,
    @required this.fileImage,
    @required this.imageUrl,
    @required this.showNetworkImage,
  }) : super(key: key);
  final Function onDelete;
  final File fileImage;
  final String imageUrl;
  final bool showNetworkImage;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: mediaQuery.width * 0.9,
          height: mediaQuery.height * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.blue,
              image: DecorationImage(
                  image: showNetworkImage
                      ? NetworkImage(
                          imageUrl,
                        )
                      : FileImage(
                          fileImage,
                        ),
                  fit: BoxFit.fill)),
        ),
        Positioned(
          top: mediaQuery.height * 0.005,
          right: mediaQuery.width * 0.005,
          child: Visibility(
            visible: !showNetworkImage,
            child: IconButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                onPressed: () => onDelete
                //   () => pickedInvoice = null,
                // ),
                ),
          ),
        )
      ],
    );
  }
}
