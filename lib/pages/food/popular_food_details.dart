import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/card_controller.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/pages/cart/cart_page.dart';
import 'package:fooddelivery/pages/home/main_food_page.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:fooddelivery/utils/app_constants.dart';
import 'package:fooddelivery/utils/dimensions.dart';
import 'package:fooddelivery/widgets/app_column.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:fooddelivery/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //backgroung image
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.popularFoodImgSize,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstans.BASE_URL +
                              AppConstans.UPLOAD_URL +
                              product.img!))),
                )),
            //icon widgets
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.Width20,
                right: Dimensions.Width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          // Get.to(() => MainFoodPage());
                          if (page == "cartpage") {
                            Get.toNamed(RouteHelper.getCartPage());
                          } else {
                            Get.toNamed(RouteHelper.getInitial());
                          }
                        },
                        child: AppIcon(icon: Icons.arrow_back)),
                    GetBuilder<PopularProductController>(
                        builder: ((controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1)
                            Get.to(() => CartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgrountColor: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ))
                                : Container(),
                          ],
                        ),
                      );
                    }))
                  ],
                )),
            //introduction to food
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.popularFoodImgSize - 15,
                child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.Width20,
                        right: Dimensions.Width20,
                        top: Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radious20),
                            topLeft: Radius.circular(Dimensions.radious20)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(
                          text: product.name!,
                        ),
                        SizedBox(height: Dimensions.height20),
                        BigText(text: "Introduce"),
                        SizedBox(height: Dimensions.height20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text: product.description!),
                          ),
                        )
                        // ExpandableTextWidget(text:"")
                      ],
                    )))
            //expandable text widget
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
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
                        GestureDetector(
                            onTap: () {
                              ////////////////////// Get
                              popularProduct.setQuantity(false);
                            },
                            child:
                                Icon(Icons.remove, color: AppColors.signColor)),
                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),
                        BigText(text: popularProduct.quantity.toString()),
                        SizedBox(
                          width: Dimensions.Width10 / 2,
                        ),
                        GestureDetector(
                            onTap: () {
                              ////////////////////// Get
                              popularProduct.setQuantity(true);
                            },
                            child: Icon(Icons.add, color: AppColors.signColor))
                      ])),
                  //
                  GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          right: Dimensions.Width20,
                          left: Dimensions.Width20),
                      child: BigText(
                        text: "\$ ${product.price!} | Add to the cart",
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
