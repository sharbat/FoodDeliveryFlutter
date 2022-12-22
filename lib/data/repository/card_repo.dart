import 'dart:convert';

import 'package:fooddelivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstans.CART_LIST);

    // sharedPreferences.remove(AppConstans.CART_HISTORY_LIST);

    var time = DateTime.now().toString();
    cart = [];
    /*
    convert onj tp string */
    cartList.forEach((element) {
      element.time = time;

      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstans.CART_LIST, cart);
    print(sharedPreferences.getStringList(AppConstans.CART_LIST));
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstans.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstans.CART_LIST)!;
      print("inside getCartList" + carts.toString());
    }

    List<CartModel> cartList = [];

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstans.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstans.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstans.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstans.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("HISTORY LIST" + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstans.CART_HISTORY_LIST, cartHistory);
    print("The length of history list is " +
        getCartHistoryList().length.toString());
    for (int j = 0; j < getCartHistoryList().length; j++) {
      print("The Lenght of history list is " +
          getCartHistoryList()[0].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstans.CART_LIST);
  }
}
