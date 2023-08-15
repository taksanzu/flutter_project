import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_term_food_delivery/models/categories_model.dart';
import 'package:final_term_food_delivery/models/food_categories_model.dart';
import 'package:flutter/widgets.dart';

import '../models/cart_model.dart';
import '../models/foods_model.dart';

class MyProvider extends ChangeNotifier {
// categories Burger
  List<CategoriesModel> burgerList = [];
  Future<void> getBurgerCategoriesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('3bpJtUHkyJLT2TEb6xDM')
        .collection('burger')
        .get();

    burgerList = querySnapshot.docs.map((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      return CategoriesModel(
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    }).toList();
  }

// categories Pizza
  List<CategoriesModel> pizzaList = [];
  Future<void> getPizzaCategoriesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('3bpJtUHkyJLT2TEb6xDM')
        .collection('pizza')
        .get();

    pizzaList = querySnapshot.docs.map((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      return CategoriesModel(
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    }).toList();
  }

  // categories Chicken
  List<CategoriesModel> chickenList = [];
  Future<void> getChickenCategoriesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('3bpJtUHkyJLT2TEb6xDM')
        .collection('chicken')
        .get();
    chickenList = querySnapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      return CategoriesModel(
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    }).toList();
  }

  // categories Noodles
  List<CategoriesModel> noodlesList = [];
  Future<void> getNoodlesCategoriesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('3bpJtUHkyJLT2TEb6xDM')
        .collection('noodles')
        .get();

    noodlesList = querySnapshot.docs.map((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      return CategoriesModel(
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    }).toList();
  }

  // categories Salad
  List<CategoriesModel> saladList = [];
  Future<void> getSaladCategoriesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('3bpJtUHkyJLT2TEb6xDM')
        .collection('salad')
        .get();

    saladList = querySnapshot.docs.map((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      return CategoriesModel(
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    }).toList();
  }

  // categories Drinks
  List<CategoriesModel> drinksList = [];
  Future<void> getDrinksCategoriesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('3bpJtUHkyJLT2TEb6xDM')
        .collection('drinks')
        .get();

    drinksList = querySnapshot.docs.map((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      return CategoriesModel(
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    }).toList();
  }

  // categories Desert
  List<CategoriesModel> desertList = [];
  Future<void> getDesertCategoriesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('3bpJtUHkyJLT2TEb6xDM')
        .collection('desert')
        .get();

    desertList = querySnapshot.docs.map((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      return CategoriesModel(
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    }).toList();
  }

  // foodList
  List<FoodModel> foodList = [];
  Future<void> getFoodData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('foods').get();

      // Clear the existing list before adding new items
      foodList.clear();

      // Use for loop to ensure sequential loading
      for (var element in querySnapshot.docs) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodModel newFood = FoodModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        foodList.add(newFood);
      }
    } catch (error) {
      print('Error loading food data: $error');
    }
  }

  // burger category
  List<FoodCategoriesModel> burgerCategoryList = [];

  Future<void> getBurgerCategoriesList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('foodsCategories')
          .doc('6InMz0ikLGyk5mESUu4X')
          .collection('burger')
          .get();

      burgerCategoryList.clear();

      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodCategoriesModel newBurgerCategories = FoodCategoriesModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        burgerCategoryList.add(newBurgerCategories);
      });

      print('Burger Category List Length: ${burgerCategoryList.length}');
    } catch (error) {
      print('Error loading burger category data: $error');
    }
  }

  // pizza category
  List<FoodCategoriesModel> pizzaCategoryList = [];

  Future<void> getPizzaCategoriesList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('foodsCategories')
          .doc('6InMz0ikLGyk5mESUu4X')
          .collection('pizza')
          .get();

      pizzaCategoryList.clear();

      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodCategoriesModel newPizzaCategories = FoodCategoriesModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        pizzaCategoryList.add(newPizzaCategories);
      });

      print('Pizza Category List Length: ${pizzaCategoryList.length}');
    } catch (error) {
      print('Error loading pizza category data: $error');
    }
  }

  // chicken category
  List<FoodCategoriesModel> chickenCategoryList = [];

  Future<void> getChickenCategoriesList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('foodsCategories')
          .doc('6InMz0ikLGyk5mESUu4X')
          .collection('chicken')
          .get();

      chickenCategoryList.clear();

      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodCategoriesModel newChickenCategories = FoodCategoriesModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        chickenCategoryList.add(newChickenCategories);
      });

      print('Chicken Category List Length: ${chickenCategoryList.length}');
    } catch (error) {
      print('Error loading chicken category data: $error');
    }
  }

// noodles category
  List<FoodCategoriesModel> noodlesCategoryList = [];

  Future<void> getNoodlesCategoriesList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('foodsCategories')
          .doc('6InMz0ikLGyk5mESUu4X')
          .collection('noodles')
          .get();

      noodlesCategoryList.clear();

      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodCategoriesModel newNoodlesCategories = FoodCategoriesModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        noodlesCategoryList.add(newNoodlesCategories);
      });

      print('Noodles Category List Length: ${noodlesCategoryList.length}');
    } catch (error) {
      print('Error loading noodles category data: $error');
    }
  }

  // salad category
  List<FoodCategoriesModel> saladCategoryList = [];

  Future<void> getSaladCategoriesList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('foodsCategories')
          .doc('6InMz0ikLGyk5mESUu4X')
          .collection('salad')
          .get();

      saladCategoryList.clear();

      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodCategoriesModel newSaladCategories = FoodCategoriesModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        saladCategoryList.add(newSaladCategories);
      });

      print('Salad Category List Length: ${saladCategoryList.length}');
    } catch (error) {
      print('Error loading salad category data: $error');
    }
  }

  // drink category
  List<FoodCategoriesModel> drinksCategoryList = [];

  Future<void> getDrinksCategoriesList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('foodsCategories')
          .doc('6InMz0ikLGyk5mESUu4X')
          .collection('drinks')
          .get();

      drinksCategoryList.clear();

      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodCategoriesModel newDrinksCategories = FoodCategoriesModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        drinksCategoryList.add(newDrinksCategories);
      });

      print('Drinks Category List Length: ${drinksCategoryList.length}');
    } catch (error) {
      print('Error loading drinks category data: $error');
    }
  }

// dessert category
  List<FoodCategoriesModel> desertCategoryList = [];

  Future<void> getDesertCategoriesList() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('foodsCategories')
          .doc('6InMz0ikLGyk5mESUu4X')
          .collection('desert')
          .get();

      desertCategoryList.clear();

      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        FoodCategoriesModel newDesertCategories = FoodCategoriesModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'] ?? 0,
        );
        desertCategoryList.add(newDesertCategories);
      });

      print('Desert Category List Length: ${desertCategoryList.length}');
    } catch (error) {
      print('Error loading desert category data: $error');
    }
  }

  // Cart
  List<CartModel> cartList = [];
  CartModel cartModel = CartModel(
    name: '',
    image: '',
    price: 0,
    quantity: 0,
  );
  void addToCart(
      {required String image,
      required String name,
      required int price,
      required int quantity}) {
    cartModel = CartModel(
      name: name,
      image: image,
      price: price,
      quantity: quantity,
    );
    cartList.add(cartModel);
    notifyListeners();
  }

  int totalprice() {
    int total = 0;
    cartList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  void delete(int index) {
    cartList.removeAt(index);
    notifyListeners();
  }
}
