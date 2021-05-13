import 'package:flutter/material.dart';

class ProfileBannerWidget extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final bool isEdit;
  final Function onTap;
  ProfileBannerWidget({
    @required this.name,
    @required this.image,
    this.isEdit = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: mediaQuery.height * 0.2,
        width: mediaQuery.width * 0.85,
        decoration: BoxDecoration(
          color: Color(0xff272D45),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: image, 
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Visibility(
                    visible: isEdit,
                    child: InkWell(
                      onTap: onTap,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffA4BE25),
                          radius: 13,
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            Visibility(
              visible: name.isNotEmpty,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
