import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;
  final Function(Map<String, dynamic>) onViewDetails;

  FavoritesPage({
    required this.favorites,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.deepPurple,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                'No favorite products added yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading:
                      Image.asset(product['imagePath'], width: 50, height: 50),
                  title: Text(product['name']),
                  subtitle: Text('\$${product['price'].toStringAsFixed(2)}'),
                  onTap: () {
                    onViewDetails(product);
                  },
                );
              },
            ),
    );
  }
}
