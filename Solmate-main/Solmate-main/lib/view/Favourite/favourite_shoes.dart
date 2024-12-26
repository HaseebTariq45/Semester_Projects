import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../detail/detail_screen.dart';
// import 'detail_screen.dart'; // Import the detail screen

class FavoriteShoesScreen extends StatelessWidget {
  final String userEmail; // Pass the email of the logged-in user

  const FavoriteShoesScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Shoes"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('favoriteShoes')
            .where('userEmail', isEqualTo: userEmail) // Filter by logged-in user's email
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No favorite shoes yet!"),
                ],
              ),
            );
          }

          final favoriteShoes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favoriteShoes.length,
            itemBuilder: (ctx, index) {
              final shoeData = favoriteShoes[index].data() as Map<String, dynamic>;
              final shoeName = shoeData['name'] as String;
              final shoeModel = shoeData['model'] as String;

              return ListTile(
                title: Text(shoeName, style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text(shoeModel, style: Theme.of(context).textTheme.titleMedium),
                onTap: () {
                  // Navigate to detail screen with shoe model data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                        model: shoeData['model'],
                        isComeFromMoreSection: false,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
