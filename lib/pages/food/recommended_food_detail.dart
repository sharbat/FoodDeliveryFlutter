import 'package:flutter/material.dart';
import 'package:fooddelivery/controllers/popular_product_controller.dart';
import 'package:fooddelivery/routes/route_helper.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimensions.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/card_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/app_constants.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;

  RecommendedFoodDetails({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.clear),
                    ),
                    // AppIcon(icon: Icons.shopping_cart_outlined)
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
                  ]),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                    child: Center(
                        child: BigText(
                      size: Dimensions.font26,
                      text: product.name!,
                    )),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radious20),
                          topRight: Radius.circular(Dimensions.radious20),
                        )),
                  )),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                      AppConstans.BASE_URL +
                          AppConstans.UPLOAD_URL +
                          product.img!,
                      width: double.maxFinite,
                      fit: BoxFit.cover)),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: product.description!),
                  margin: EdgeInsets.only(
                      left: Dimensions.Width20, right: Dimensions.Width20),
                )
              ],
            ))
          ],
        ),

        //bottom
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.Width20 * 2.5,
                      right: Dimensions.Width20 * 2.5,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                            iconSize: Dimensions.iceonSize24,
                            iconColor: Colors.white,
                            backgrountColor: AppColors.mainColor,
                            icon: Icons.remove),
                      ),
                      BigText(
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font26,
                          text:
                              "\$ ${product.price!}  X  ${controller.inCardItems} "),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            iconSize: Dimensions.iceonSize24,
                            iconColor: Colors.white,
                            backgrountColor: AppColors.mainColor,
                            icon: Icons.add),
                      )
                    ],
                  ),
                ),
                Container(
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
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          ),
                        ),
                        //
                        GestureDetector(
                          onTap: () {
                            controller.addItem(product);
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
                ),
              ],
            );
          },
        ));
  }
}
