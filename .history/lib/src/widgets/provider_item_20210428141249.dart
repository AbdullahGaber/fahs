import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProviderItem extends StatelessWidget {
  final String providerImage;
  final String providerName;
  final double providerRate;
  final double providerDistance;
  final String serviceCost;
  final Function onPressed;
  final bool showCircleImage;
  ProviderItem({
    @required this.providerName,
    @required this.providerImage,
    @required this.providerRate,
    @required this.providerDistance,
    @required this.serviceCost,
    @required this.onPressed,
    this.showCircleImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        onTap: onPressed,
        //TODO : replace with NetworkImage after connecting to api...
        leading:showCircleImage? CircleAvatar(
          backgroundImage: AssetImage(providerImage),
        ):ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.asset(
                  providerImage,
                  fit: BoxFit.fill,
                ),
              ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              providerName,
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
                '${providerDistance}m',
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
              rating: provider,
              isReadOnly: true,
              borderColor: Colors.black,
              size: 15,
              color: Color(0xff02A5E9),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'SR ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: '$serviceCost',
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
    );
  }
}
