import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            30.verticalSpace, // Spacing at the top
            const ScreenTitle(title: 'Home'), // Screen title
            20.verticalSpace, // Spacing below the title
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.w,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 0.8, // Adjust as per design
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) => ProductItem(
                  product: controller.products[index],
                ),
              ),
            ),
            10.verticalSpace, // Optional bottom spacing
          ],
        ),
      ),
    );
  }
}
