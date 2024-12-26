import 'package:flutter/material.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';
import 'package:sneakers_app/utils/paymnet_methods.dart';
import '../../../utils/app_methods.dart';
import '../../../animation/fadeanimation.dart';
import '../../../utils/constants.dart';
import 'empty_list.dart';
import '../../../data/dummy_data.dart';
import '../../../models/models.dart';

class BodyBagView extends StatefulWidget {
  const BodyBagView({Key? key}) : super(key: key);

  @override
  _BodyBagViewState createState() => _BodyBagViewState();
}

class _BodyBagViewState extends State<BodyBagView>
    with SingleTickerProviderStateMixin {
  int lengthsOfItemsOnBag = itemsOnBag.length;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02), // Responsive margin
      width: width,
      height: height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            topText(width, height),
            Divider(color: Colors.grey),
            itemsOnBag.isEmpty
                ? EmptyList()
                : Column(children: [
              mainListView(width, height),
              SizedBox(height: height * 0.02), // Responsive height
              bottomInfo(width, height),
            ])
          ],
        ),
      ),
    );
  }

  // Top Texts Components
  Widget topText(double width, double height) {
    return Container(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text("My Bag", style: AppThemes.bagTitle),
            Text(
              "Total ${lengthsOfItemsOnBag} Items",
              style: AppThemes.bagTotalPrice,
            ),
          ],
        ),
      ),
    );
  }

  // Material Button Components
  Widget materialButton(double width, double height) {
    return FadeAnimation(
      delay: 3,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minWidth: width * 0.9, // Responsive width
        height: height / 15,
        color: AppConstantsColor.materialButtonColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentModeScreen()));
        },
        child: Text(
          "NEXT",
          style: TextStyle(color: AppConstantsColor.lightTextColor),
        ),
      ),
    );
  }

  // Main ListView Components
  Widget mainListView(double width, double height) {
    return Container(
      width: width,
      height: height / 1.6,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: itemsOnBag.length,
        itemBuilder: (ctx, index) {
          ShoeModel currentBagItem = itemsOnBag[index];

          return FadeAnimation(
            delay: 1.5 * index / 4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.01), // Responsive margin
              width: width,
              height: height / 5.2,
              child: Row(
                children: [
                  Container(
                    width: width / 2.8,
                    height: height / 5.7,
                    child: Stack(children: [
                      Positioned(
                        top: 20,
                        left: 10,
                        child: Container(
                          width: width / 3.6,
                          height: height / 7.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[350],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        bottom: 15,
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(-40 / 360),
                          child: Container(
                            width: 140,
                            height: 140,
                            child: Image(
                              image: AssetImage(currentBagItem.imgAddress),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.1), // Responsive padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentBagItem.model, style: AppThemes.bagProductModel),
                        SizedBox(height: height * 0.01), // Responsive height
                        Text("\$${currentBagItem.price}", style: AppThemes.bagProductPrice),
                        SizedBox(height: height * 0.01), // Responsive height
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  itemsOnBag.remove(currentBagItem);
                                  lengthsOfItemsOnBag = itemsOnBag.length;
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Center(child: Icon(Icons.remove, size: 15)),
                              ),
                            ),
                            SizedBox(width: width * 0.03), // Responsive width
                            Text("1", style: AppThemes.bagProductNumOfShoe),
                            SizedBox(width: width * 0.03), // Responsive width
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Center(child: Icon(Icons.add, size: 15)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottomInfo(double width, double height) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: height / 7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FadeAnimation(
              delay: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TOTAL", style: AppThemes.bagTotalPrice),
                  Text("\$${AppMethods.sumOfItemsOnBag()}", style: AppThemes.bagSumOfItemOnBag),
                ],
              ),
            ),
            SizedBox(height: height * 0.04), // Responsive height
            materialButton(width, height),
          ],
        ),
      ),
    );
  }
}
