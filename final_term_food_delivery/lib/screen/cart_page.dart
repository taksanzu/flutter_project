import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/my_provider.dart';
import 'home_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget cartItem({
    required String image,
    required String name,
    required int price,
    required int quantity,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Container(
          width: 170,
          height: 170,
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(image),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Price",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "\$ $price",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "$quantity",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: onTap,
            )
          ],
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    int total = provider.totalprice();
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$ $total",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              "Check Out",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: provider.cartList.length,
        itemBuilder: (ctx, index) {
          return cartItem(
            onTap: () {
              provider.delete(index); // Truyền index trực tiếp vào hàm delete
            },
            image: provider.cartList[index].image,
            name: provider.cartList[index].name,
            price: provider.cartList[index].price,
            quantity: provider.cartList[index].quantity,
          );
        },
      ),
    );
  }
}
