import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/card_controller.dart';
import 'package:fooddelivery/data/repository/popular_product_repo.dart';
import 'package:fooddelivery/models/popular_product_model.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCardItems = 0;
  int get inCardItems => _inCardItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      //  print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = chackQuantity(_quantity + 1);
      print("number of items " + _quantity.toString());
    } else {
      _quantity = chackQuantity(_quantity - 1);
    }
    update();
  }

//_inCartItems
  int chackQuantity(int quantity) {
    if (_inCardItems + quantity < 0) {
      Get.snackbar("Item count", "You can't reduce more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCardItems > 0) {
        _quantity = -_inCardItems;
        return quantity;
      }
      return 0;
    } else if (_inCardItems + quantity > 20) {
      Get.snackbar("Item count", "You can't reduce more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCardItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    print("exist or not " + exist.toString());
    if (exist) {
      _inCardItems = _cart.getQuantity(product);
    }
    print("the quantity in the cart is " + _inCardItems.toString());

    //get from storage _inCardItems
  }

  void addItem(ProductModel product) {
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCardItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          " The quantity is " +
          value.quantity.toString());
    });
    // } else {
    //   Get.snackbar("Item count", "You shuld at least add an item in the cart!",
    //       backgroundColor: AppColors.mainColor, colorText: Colors.white);
    // }
    update();
  }

  int get totalItems {
    //  var totalQuantity = 0;

    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
