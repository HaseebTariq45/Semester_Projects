import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sneakers_app/Authentication/accountmanagment.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:sneakers_app/view/Favourite/favourite_shoes.dart';
import '../../../animation/fadeanimation.dart';
import '../../../models/models.dart';
import '../../../utils/constants.dart';
import '../../../widget/location.dart';
import 'repeated_list.dart';
import '../../../data/dummy_data.dart';
import '../../../utils/paymnet_methods.dart';  // <-- Import the PaymentModeScreen file

class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  _BodyProfileState createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  int statusCurrentIndex = 0;
  String userName = '';
  var userEmail; // Default name for the user

  @override
  void initState() {
    super.initState();
    getUserName().then((name) {
      setState(() {
        userName = name!;
      });
    });
  }

  // Fetch the logged-in user's display name
  void navigateToFavoriteShoes(BuildContext context, String userEmail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteShoesScreen(userEmail: userEmail),
      ),
    );
  }

  Future<String?> getUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) // Use user.uid for document ID (recommended)
            .get();

        if (docSnapshot.exists) {
          final userName = docSnapshot.data()?['name'];
          return userName ?? 'User'; // Default value if 'name' is absent
        } else {
          print("User document does not exist.");
          return null; // Handle document absence or errors
        }
      } on FirebaseException catch (e) {
        print("Error fetching user data: ${e.message}");
        return null; // Handle potential Firestore errors gracefully
      }
    } else {
      print("No user is logged in.");
      return null; // Handle no logged-in user gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          width: width,
          height: height,
          child: Column(
            children: [
              topProfilePicAndName(width, height),
              SizedBox(height: 30),
              middleDashboard(width, height),  // <-- Pass the width/height to the middleDashboard
              bottomSection(width, height),
            ],
          ),
        );
      },
    );
  }

  Widget topProfilePicAndName(double width, double height) {
    return FadeAnimation(
      delay: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/91388754?v=4"),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName, // Display the logged-in user's name
                style: AppThemes.profileDevName,
              ),
              Text(
                "User",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountManagementScreen()));
            },
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget middleDashboard(double width, double height) {
    return FadeAnimation(
      delay: 2,
      child: Container(
        width: width,
        height: height / 2.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "    Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),

            // Payments Tile: Added GestureDetector for navigation
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentModeScreen()), // Navigate to PaymentModeScreen
                );
              },
              child: RoundedLisTile(
                width: width,
                height: height,
                leadingBackColor: Colors.green[600],
                icon: Icons.wallet_travel_outlined,
                title: "Payments",
                trailing: Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[700],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "2 New",
                        style: TextStyle(
                          color: AppConstantsColor.lightTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppConstantsColor.lightTextColor,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),


            // Other tiles remain unchanged
            RoundedLisTile(
              width: width,
              height: height,
              leadingBackColor: Colors.yellow[600],
              icon: Icons.archive,
              title: "Store Locator",
              trailing: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LocationScreen()),
                        );
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppConstantsColor.darkTextColor,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(FavoriteShoesScreen(userEmail: userEmail));
              },
              child: RoundedLisTile(
                width: width,
                height: height,
                leadingBackColor: Colors.grey[400],
                icon: Icons.favorite,
                title: "Favourites",
                trailing: Container(
                  width: 140,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red[500],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSection(double width, double height) {
    return FadeAnimation(
      delay: 2.5,
      child: Container(
        width: width,
        height: height / 6.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "    My Account",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "    Log Out",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.red[500],
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
