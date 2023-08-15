import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final VoidCallback? onTap;
  BottomContainer(
      {required this.image, required this.price, required this.name, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 270,
        width: 220,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: CachedNetworkImageProvider(image),
            backgroundColor: Colors.white,
          ),
          ListTile(
            leading: Text(
              name,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            trailing: Text(
              "\$ $price",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 20, color: Colors.redAccent),
              Icon(Icons.star, size: 20, color: Colors.redAccent),
              Icon(Icons.star, size: 20, color: Colors.redAccent),
              Icon(Icons.star, size: 20, color: Colors.redAccent),
              Icon(Icons.star, size: 20, color: Colors.redAccent),
            ],
          )
        ]),
      ),
    );
  }
}
