import 'package:flutter/material.dart';
import 'package:fooddelivery/pages/home/food_page.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimensions.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);
  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print("Current height is " + MediaQuery.of(context).size.height.toString());
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.Width20, right: Dimensions.Width20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "Kazakhstan", color: AppColors.mainColor),
                        //
                        Row(
                          children: [
                            SmallText(
                              text: "Nur-Sultan",
                              color: Colors.black54,
                            ),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iceonSize24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radious15),
                        color: AppColors.mainColor,
                      ),
                    )
                  ])),
        ),

        //showing the body
        Expanded(
            child: SingleChildScrollView(
          child: FoodPageBody(),
        ))
      ],
    ));
  }
}
