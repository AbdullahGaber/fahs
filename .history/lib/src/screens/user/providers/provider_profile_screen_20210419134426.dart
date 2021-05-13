import 'package:flutter/material.dart';

class ProviderProfileScreen extends StatefulWidget {
  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'مركز تجربة',
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  height: mediaQuery.height * 0.15,
                  width: mediaQuery.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      'assets/images/log.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مركز تجربة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfffecb00),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Text(
                        '1.5m',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                  subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothStarRating(
              rating: 5,
              isReadOnly: true,
              borderColor: Colors.black,
              size: 15,
              color: Color(0xff02A5E9),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child:   RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'SR ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: '$price',
                        style: TextStyle(
                          color: Color(0xff1FB7F1),
                          fontSize: 15,
                        ),
                      ),
                    ]),
                  ),
            )
          ],
        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
