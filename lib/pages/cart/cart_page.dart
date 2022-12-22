import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/card_controller.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/pages/food/popular_food_details.dart';
import 'package:fooddelivery/pages/food/recommended_food_detail.dart';
import 'package:fooddelivery/pages/home/main_food_page.dart';
import 'package:fooddelivery/utils/app_constants.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimensions.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: Dimensions.Width20,
              right: Dimensions.Width20,
              top: Dimensions.Width20 * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    backgrountColor: AppColors.mainColor,
                    iconSize: Dimensions.iceonSize24,
                  ),
                  SizedBox(
                    width: Dimensions.Width20 * 5,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Get.to(() => MainFoodPage());
                    }),
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgrountColor: AppColors.mainColor,
                      iconSize: Dimensions.iceonSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgrountColor: AppColors.mainColor,
                    iconSize: Dimensions.iceonSize24,
                  ),
                ],
              ),
            ),
            Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.Width20,
                right: Dimensions.Width20,
                bottom: 0,
                child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    //color: Colors.red,
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    //height: 100,
                                    width: double.maxFinite,
                                    child: Row(children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(() => MainFoodPage());
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                          if (popularIndex >= 0) {
                                            // Get.to(() => PopularFoodDetail(
                                            //     pageId: popularIndex,"cartpage"));
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, "cartpage"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            // Get.to(() => RecommendedFoodDetails(
                                            //     pageId: recommendedIndex));
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    index, "cartpage"));
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstans.BASE_URL +
                                                        AppConstans.UPLOAD_URL +
                                                        cartController
                                                            .getItems[index]
                                                            .img!,
                                                  )),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radious20),
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.Width10,
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                color: Colors.black,
                                              ),
                                              SmallText(
                                                text: "Spicy",
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index].price
                                                        .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions
                                                              .height10,
                                                          bottom: Dimensions
                                                              .height10,
                                                          right: Dimensions
                                                              .Width10,
                                                          left: Dimensions
                                                              .Width10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radious20),
                                                          color: Colors.white),
                                                      child: Row(children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                              ////////////////////// Get
                                                              // popularProduct.setQuantity(false);
                                                            },
                                                            child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor)),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .Width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity
                                                                .toString()), //popularProduct.quantity.toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .Width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              ////////////////////// Get
                                                              // popularProduct.setQuantity(true);
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                              print("tapped");
                                                            },
                                                            child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor))
                                                      ])),
                                                  //
                                                ],
                                              )
                                            ]),
                                      ))
                                    ]),
                                  );
                                });
                          },
                        ))))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.Width20,
                right: Dimensions.Width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radious20 * 2),
                  topRight: Radius.circular(Dimensions.radious20 * 2),
                )),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          right: Dimensions.Width20,
                          left: Dimensions.Width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radious20),
                          color: Colors.white),
                      child: Row(children: [
                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),
                        BigText(
                            text:
                                "\$ " + cartController.totalAmount.toString()),
                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),
                      ])),
                  //
                  GestureDetector(
                    onTap: () {
                      //  popularProduct.addItem(product);
                      print("teapp");
                      cartController.addToHistory();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          right: Dimensions.Width20,
                          left: Dimensions.Width20),
                      child: BigText(
                        text: " Check out",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radious20),
                          color: AppColors.mainColor),
                    ),
                  )
                ]),
          );
        }));
  }
}
