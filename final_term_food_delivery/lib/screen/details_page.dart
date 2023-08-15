import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/my_provider.dart';
import 'cart_page.dart';
import 'home_page.dart';

class DetailPage extends StatefulWidget {
  String image;
  String name;
  int price;
  DetailPage({required this.image, required this.name, required this.price});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        body: Column(children: [
          Expanded(
              child: Container(
            width: double.infinity,
            color: Colors.grey[100],
            child: CircleAvatar(
              radius: 110,
              backgroundImage: CachedNetworkImageProvider(widget.image),
              backgroundColor: Colors.grey[100],
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child:
                                      Icon(Icons.remove, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$quantity",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "\$ ${widget.price}",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          )
                        ],
                      ),
                      Text(
                        "Mô tả",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "The customer app is the one that the customer is going to use. That is the briefest description for this app. The customer app helps the customer to access the online food ordering platforms, search for the right restaurant or the dish they want to order, place their orders and pay easily.",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              provider.addToCart(
                                  image: widget.image,
                                  name: widget.name,
                                  price: widget.price,
                                  quantity: quantity);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          )),
                    ],
                  )))
        ]));
  }
}
