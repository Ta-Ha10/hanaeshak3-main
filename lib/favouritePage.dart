import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favourites;
  final Function(Map<String, dynamic>) onProductSelected;

  FavouritePage({
    required this.favourites,
    required this.onProductSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        backgroundColor: Colors.deepPurple,
      ),
      body: favourites.isEmpty
          ? Center(
              child: Text('No favourites yet!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final product = favourites[index];
                return GestureDetector(
                  onTap: () {
                    onProductSelected(product);
                    Navigator.pop(context);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Image.asset(
                          product['imagePath'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$${product['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
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
