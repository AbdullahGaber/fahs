import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class ImageViewScreen extends StatefulWidget {
  final String senderName;
  final String dateTime;
  final String imageUrl;
  ImageViewScreen({
    @required this.senderName,
    @required this.imageUrl,
    @required this.dateTime,
  });
  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (c) {
              print('sssdoub');
              ImageDownloader.downloadImage(widget.imageUrl).then((value) {
                Fluttertoast.showToast(msg: 'تم حفظ الصورة بنجاح');
                print('done');
              }, onError: (v) {
                print(v);
                Fluttertoast.showToast(
                  msg: 'حدث خطأ ما , يرجى إعادة المحاولة',
                  backgroundColor: Colors.red,
                );
                print('ىخف done');
              });
            },
            color: Colors.white,
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'تنزيل الصورة',
                ),
                value: 'download',
              ),
            ],
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.centerRight,
          child: Column(
            children: [
              Text(
                widget.senderName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                widget.dateTime,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: widget.imageUrl,
          child: PinchZoomImage(
            image: Image.network(
              widget.imageUrl,
              fit: BoxFit.fill,
            ),
            zoomedBackgroundColor: Colors.black,
            hideStatusBarWhileZooming: true,
          ),
        ),
      ),
    );
  }
}
