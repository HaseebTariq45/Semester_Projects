import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';

import '../../../animation/fadeanimation.dart';
import '../../../utils/constants.dart';
import '../../../models/shoe_model.dart';
import '../../detail/detail_screen.dart';
import '../../../data/dummy_data.dart';
import 'app_bar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final User? currentUser = FirebaseAuth.instance.currentUser; // Get logged-in user
// Keep track of the favorite status for each shoe
  final Map<String, bool> favoritedShoes = {};


  void toggleFavorite(ShoeModel shoe) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final String userEmail = currentUser.email!;
    final favCollection = FirebaseFirestore.instance.collection('favorites');

    // Check if the shoe is already in the favorites collection
    final favDoc = await favCollection
        .where('email', isEqualTo: userEmail)
        .where('name', isEqualTo: shoe.name)
        .get();

    bool isFavorited = favoritedShoes[shoe.name] ?? false;

    if (favDoc.docs.isNotEmpty) {
      // If favorited, remove it from Firestore and update locally
      await favCollection.doc(favDoc.docs.first.id).delete();
      setState(() {
        favoritedShoes[shoe.name] = false;
      });
    } else {
      // If not favorited, add it to Firestore and update locally
      await favCollection.add({
        'email': userEmail,
        'name': shoe.name,
        'model': shoe.model,
      });
      setState(() {
        favoritedShoes[shoe.name] = true;
      });
    }
  }

  bool isFavorited(ShoeModel shoe) {
    return favoritedShoes[shoe.name] ?? false;
  }

  // void toggleFavorite(ShoeModel shoe) async {
  //   if (currentUser == null) return; // Ensure user is logged in
  //   final String userEmail = currentUser!.email!;
  //   final favCollection = FirebaseFirestore.instance.collection('favorites');
  //
  //   // Check if the shoe is already favorited by this user
  //   final favDoc = await favCollection
  //       .where('email', isEqualTo: userEmail)
  //       .where('name', isEqualTo: shoe.name)
  //       .get();
  //
  //   if (favDoc.docs.isNotEmpty) {
  //     // Remove from Firestore if already favorited
  //     await favCollection.doc(favDoc.docs.first.id).delete();
  //   } else {
  //     // Add to Firestore if not favorited
  //     await favCollection.add({
  //       'email': userEmail,
  //       'name': shoe.name,
  //       'model': shoe.model,
  //     });
  //   }
  //
  //   setState(() {}); // Update UI
  // }

  // bool iFavorited(ShoeModel shoe) {
  //   // Implement logic to check Firestore if the shoe is favorited
  //   return false; // Placeholder logic
  // }
  int selectedIndexOfCategory = 0;
  int selectedIndexOfFeatured = 1;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<ShoeModel> filteredShoes = availableShoes; // Initially shows all shoes

  // Categories for filtering
  List<String> categories = ["NIKE", "ADIDAS", "JORDAN", "PUMA"];

  // Method to filter shoes based on selected category
  void filterShoesByCategory(String category) {
    setState(() {
      filteredShoes = availableShoes.where((shoe) => shoe.name == category).toList();
    });
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchController.clear();
        filteredShoes = availableShoes; // Reset filtered list when search is canceled
      }
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      filteredShoes = availableShoes.where((shoe) {
        final nameLower = shoe.name.toLowerCase();
        final modelLower = shoe.model.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower) || modelLower.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Add themeMode and toggleTheme here
    ThemeMode themeMode = ThemeMode.light; // You can replace this with your theme logic
    void toggleTheme() {
      setState(() {
        themeMode = (themeMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
      });
    }

    return Scaffold(
      appBar: customAppBar(
        isSearching: isSearching,
        toggleSearch: toggleSearch,
        searchController: searchController,
        onSearchChanged: onSearchChanged,
        themeMode: themeMode,  // This is the current theme mode
        toggleTheme: toggleTheme,  // This is the function that toggles the theme
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isSearching)
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredShoes.length,
                itemBuilder: (ctx, index) {
                  ShoeModel shoe = filteredShoes[index];
                  return ListTile(
                    title: Text(shoe.name),
                    subtitle: Text(shoe.model),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            model: shoe,
                            isComeFromMoreSection: false,
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            else
              Column(
                children: [
                  topCategoriesWidget(width, height),
                  SizedBox(height: height * 0.01),
                  // Display filtered shoes based on selected category
                  middleCategoriesWidget(width, height),
                  SizedBox(height: height * 0.005),
                  moreTextWidget(),
                  lastCategoriesWidget(width, height),
                ],
              ),
          ],
        ),
      ),
    );
  }


  // Top Categories Widget Components
  Widget topCategoriesWidget(double width, double height) {
    return SizedBox(
      height: height * 0.055,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndexOfCategory = index;
                filterShoesByCategory(categories[index]); // Filter shoes by selected category
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: selectedIndexOfCategory == index ? width * 0.055 : width * 0.045,
                  color: selectedIndexOfCategory == index
                      ? AppConstantsColor.darkTextColor
                      : AppConstantsColor.unSelectedTextColor,
                  fontWeight: selectedIndexOfCategory == index
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Middle Categories Widget Components
  Widget middleCategoriesWidget(double width, double height) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.1,
          height: height * 0.37,
          child: RotatedBox(
            quarterTurns: -1,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: featured.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexOfFeatured = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Text(
                      featured[index],
                      style: TextStyle(
                        fontSize: selectedIndexOfFeatured == index ? width * 0.05 : width * 0.045,
                        color: selectedIndexOfFeatured == index
                            ? AppConstantsColor.darkTextColor
                            : AppConstantsColor.unSelectedTextColor,
                        fontWeight: selectedIndexOfFeatured == index
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: width * 0.8,
          height: height * 0.4,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: filteredShoes.length, // Use filteredShoes here
            itemBuilder: (ctx, index) {
              ShoeModel model = filteredShoes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                        model: model,
                        isComeFromMoreSection: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(width * 0.04),
                  width: width * 0.7,
                  child: Stack(
                    children: [
                      Container(
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          color: model.modelColor,
                          borderRadius: BorderRadius.circular(width * 0.08),
                        ),
                      ),
                      Positioned(
                        left: width * 0.02,
                        child: FadeAnimation(
                          delay: 1,
                          child: Row(
                            children: [
                              Text(model.name, style: AppThemes.homeProductName),
                              SizedBox(width: width * 0.3),
                              IconButton(
                                onPressed: () => toggleFavorite(model), // Just call toggleFavorite here
                                icon: Icon(
                                  isFavorited(model) ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorited(model) ? Colors.red : Colors.grey, // Red when favorited, grey otherwise
                                ),
                              )


                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.06,
                        left: width * 0.02,
                        child: FadeAnimation(
                          delay: 1.5,
                          child: Text(model.model, style: AppThemes.homeProductModel),
                        ),
                      ),
                      Positioned(
                        top: height * 0.12,
                        left: width * 0.02,
                        child: FadeAnimation(
                          delay: 2,
                          child: Text(
                            "\$${model.price.toStringAsFixed(2)}",
                            style: AppThemes.homeProductPrice,
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.05,
                        top: height * 0.1,
                        child: FadeAnimation(
                          delay: 2,
                          child: Hero(
                            tag: model.imgAddress,
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(-30 / 360),
                              child: SizedBox(
                                width: width * 0.7,
                                height: height * 0.35,
                                child: Image(
                                  image: AssetImage(model.imgAddress),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.02,
                        left: width * 0.6,
                        child: IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.arrowCircleRight,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  // More Text Widget Components
  Widget moreTextWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text("More", style: AppThemes.homeMoreText),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              CupertinoIcons.arrow_right,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }

  // Last Categories Widget Components
  Widget lastCategoriesWidget(double width, double height) {
    return SizedBox(
      height: height * 0.25,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: filteredShoes.length, // Use filteredShoes here
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          ShoeModel model = filteredShoes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => DetailScreen(
                    model: model,
                    isComeFromMoreSection: false,
                  ),
                ),
              );
            },
            child: Container(
              width: width * 0.35,
              margin: EdgeInsets.all(width * 0.02),
              decoration: BoxDecoration(
                color: model.modelColor,
                borderRadius: BorderRadius.circular(width * 0.06),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: width * 0.02,
                    top: height * 0.02,
                    child: SizedBox(
                      width: width * 0.25,
                      height: height * 0.1,
                      child: Image.asset(
                        model.imgAddress,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.13,
                    left: width * 0.04,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.name, style: AppThemes.homeProductName),
                        SizedBox(height: height * 0.005),
                        Text("\$${model.price.toStringAsFixed(2)}", style: AppThemes.homeProductPrice),
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
}

