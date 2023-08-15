import 'package:final_term_food_delivery/models/food_categories_model.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';
import 'home_page.dart';
import 'wiget/bottom_container.dart';

class Categories extends StatelessWidget {
  List<FoodCategoriesModel> list = [];
  Categories({required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          },
        ),
      ),
      body: GridView.count(
          shrinkWrap: false,
          primary: false,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: list
              .map(
                (e) => BottomContainer(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DetailPage(
                              image: e.image,
                              name: e.name,
                              price: e.price,
                            )));
                  },
                  image: e.image,
                  price: e.price,
                  name: e.name,
                ),
              )
              .toList()),
    );
  }
}
