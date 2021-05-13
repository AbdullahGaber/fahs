import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProviderItem extends StatelessWidget {
  final String providerImage;
  final String providerName;
  final double providerRate;
  final double providerDistance;
  final String serviceCost;
  ProviderItem({
    @required this.providerName,
    @required this.providerImage,
    @required this.providerRate,
    @required this.providerDistance,
    @required this.serviceCost,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        //TODO : replace with NetworkImage after connecting to api...
        leading: CircleAvatar(backgroundImage:AssetImage(providerImage),),
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
              rating: 5,
              isReadOnly: true,
              borderColor: Colors.black,
              size: 15,
              color: Color(0xff02A5E9),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                'sr $serviceCost',
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
