import 'package:flutter/material.dart';

class ProviderItem extends StatelessWidget {
  final String providerImage;
  final String providerName;
  final double providerRate;
  final double providerDistance;
  final String serviceCost;
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'مركز عبدالله',
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
              '1.5mm',
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
              'sr 3434344',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
