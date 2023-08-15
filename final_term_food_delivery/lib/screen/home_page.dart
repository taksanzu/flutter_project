import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_term_food_delivery/models/categories_model.dart';
import 'package:final_term_food_delivery/models/food_categories_model.dart';
import 'package:final_term_food_delivery/models/foods_model.dart';
import 'package:final_term_food_delivery/provider/my_provider.dart';
import 'package:final_term_food_delivery/screen/cart_page.dart';
import 'package:final_term_food_delivery/screen/categories.dart';
import 'package:final_term_food_delivery/screen/details_page.dart';
import 'package:final_term_food_delivery/screen/wiget/bottom_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_us.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModel> burgerList = [];
  List<CategoriesModel> pizzaList = [];
  List<CategoriesModel> chickenList = [];
  List<CategoriesModel> noodlesList = [];
  List<CategoriesModel> saladList = [];
  List<CategoriesModel> drinkList = [];
  List<CategoriesModel> desertList = [];
  List<FoodModel> foodList = [];

  List<FoodCategoriesModel> burgerFoodList = [];
  List<FoodCategoriesModel> pizzaFoodList = [];
  List<FoodCategoriesModel> chickenFoodList = [];
  List<FoodCategoriesModel> noodlesFoodList = [];
  List<FoodCategoriesModel> saladFoodList = [];
  List<FoodCategoriesModel> drinkFoodList = [];
  List<FoodCategoriesModel> desertFoodList = [];

  bool _dataLoaded = false;

  Widget categoriesContainer(
      {required String image,
      required String name,
      required VoidCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_dataLoaded) {
      MyProvider provider = Provider.of<MyProvider>(context, listen: true);
      provider.getBurgerCategoriesData().then((_) {
        setState(() {
          burgerList = provider.burgerList;
          _dataLoaded = true;
        });
      });
      provider.getPizzaCategoriesData().then((_) {
        setState(() {
          pizzaList = provider.pizzaList;
          _dataLoaded = true;
        });
      });
      provider.getChickenCategoriesData().then((_) {
        setState(() {
          chickenList = provider.chickenList;
          _dataLoaded = true;
        });
      });
      provider.getNoodlesCategoriesData().then((_) {
        setState(() {
          noodlesList = provider.noodlesList;
          _dataLoaded = true;
        });
      });
      provider.getSaladCategoriesData().then((_) {
        setState(() {
          saladList = provider.saladList;
          _dataLoaded = true;
        });
      });
      provider.getDrinksCategoriesData().then((_) {
        setState(() {
          drinkList = provider.drinksList;
          _dataLoaded = true;
        });
      });
      provider.getDesertCategoriesData().then((_) {
        setState(() {
          desertList = provider.desertList;
          _dataLoaded = true;
        });
      });
      provider.getFoodData().then((_) {
        setState(() {
          foodList = provider.foodList;
          _dataLoaded = true;
        });
      });

      //categories food
      provider.getBurgerCategoriesList().then((_) {
        setState(() {
          burgerFoodList = provider.burgerCategoryList;
          _dataLoaded = true;
        });
      });
      provider.getPizzaCategoriesList().then((_) {
        setState(() {
          pizzaFoodList = provider.pizzaCategoryList;
          _dataLoaded = true;
        });
      });
      provider.getChickenCategoriesList().then((_) {
        setState(() {
          chickenFoodList = provider.chickenCategoryList;
          _dataLoaded = true;
        });
      });
      provider.getNoodlesCategoriesList().then((_) {
        setState(() {
          noodlesFoodList = provider.noodlesCategoryList;
          _dataLoaded = true;
        });
      });
      provider.getSaladCategoriesList().then((_) {
        setState(() {
          saladFoodList = provider.saladCategoryList;
          _dataLoaded = true;
        });
      });
      provider.getDrinksCategoriesList().then((_) {
        setState(() {
          drinkFoodList = provider.drinksCategoryList;
          _dataLoaded = true;
        });
      });
      provider.getDesertCategoriesList().then((_) {
        setState(() {
          desertFoodList = provider.desertCategoryList;
          _dataLoaded = true;
        });
      });
    }
  }

  Widget drawer(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
      ),
      onTap: onTap,
    );
  }

  Widget burger() {
    return Row(
      children: burgerList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Categories(
                            list: burgerFoodList,
                          )));
                },
              ))
          .toList(),
    );
  }

  Widget pizza() {
    return Row(
      children: pizzaList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Categories(
                            list: pizzaFoodList,
                          )));
                },
              ))
          .toList(),
    );
  }

  Widget chicken() {
    return Row(
      children: chickenList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Categories(
                            list: chickenFoodList,
                          )));
                },
              ))
          .toList(),
    );
  }

  Widget noodles() {
    return Row(
      children: noodlesList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Categories(
                            list: noodlesFoodList,
                          )));
                },
              ))
          .toList(),
    );
  }

  Widget salad() {
    return Row(
      children: saladList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Categories(
                            list: saladFoodList,
                          )));
                },
              ))
          .toList(),
    );
  }

  Widget drinks() {
    return Row(
      children: drinkList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Categories(
                            list: drinkFoodList,
                          )));
                },
              ))
          .toList(),
    );
  }

  Widget desert() {
    return Row(
      children: desertList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Categories(
                            list: desertFoodList,
                          )));
                },
              ))
          .toList(),
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.redAccent[100],
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("images/logo.png"),
                    ),
                    accountName: Text("Khang"),
                    accountEmail: Text("khang@gmail.com")),
                drawer(icon: Icons.person, title: "Profile", onTap: () {}),
                drawer(
                    icon: Icons.shopping_cart,
                    title: "Cart",
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => CartPage()));
                    }),
                drawer(
                    icon: Icons.info_outline,
                    title: "About Us",
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    }),
                Divider(
                  thickness: 3,
                  color: Colors.redAccent[100],
                ),
                ListTile(
                  leading: Text(
                    "Comunicate",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
                drawer(
                    icon: Icons.lock, title: "Change Password", onTap: () {}),
                drawer(
                    icon: Icons.logout,
                    title: "Log Out",
                    onTap: () {
                      logout();
                    }),
              ])),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/logo.png"),
            ),
          )
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search, color: Colors.redAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              burger(),
              pizza(),
              chicken(),
              noodles(),
              salad(),
              drinks(),
              desert(),
            ],
          ),
        ),
        Divider(
          thickness: 5,
          color: Colors.redAccent[100],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 400,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            shrinkWrap: false,
            primary: false,
            children: foodList
                .map((e) => BottomContainer(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  image: e.image,
                                  name: e.name,
                                  price: e.price,
                                )));
                      },
                      image: e.image,
                      name: e.name,
                      price: e.price,
                    ))
                .toList(),
          ),
        )
      ]),
    );
  }
}
