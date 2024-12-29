import 'package:flutter/material.dart';

import 'CartPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e-commerce',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isProductSelected = false;
  bool isGridView = true; // State for switching between GridView and ListView
  String selectedImagePath = '';
  String selectedProductName = '';
  String selectedProductDescription = '';
  double selectedProductPrice = 0.0;
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Hoodies',
    'Jackets',
    'T-Shirts',
    'Blouses'
  ];
  final List<Map<String, dynamic>> products = [
    {
      'imagePath': 'images/assets/image1.jpg',
      'name': 'Blouse',
      'category': 'Blouses',
      'description':
          'A stylish blouse perfect for casual and formal occasions.',
      'price': 12.0,
      'rating': 4.5,
    },
    {
      'imagePath': 'images/assets/image2.jpg',
      'name': 'T-Shirt',
      'category': 'T-Shirts',
      'description': 'Comfortable and casual, ideal for everyday wear.',
      'price': 10.0,
      'rating': 4.0,
    },
    {
      'imagePath': 'images/assets/image3.jpg',
      'name': 'Crop Top',
      'category': 'Blouses',
      'description': 'Trendy crop top for a modern look.',
      'price': 15.0,
      'rating': 4.8,
    },
    {
      'imagePath': 'images/assets/image4.jpg',
      'name': 'Hoodie',
      'category': 'Hoodies',
      'description': 'A cozy hoodie to keep you warm.',
      'price': 20.0,
      'rating': 4.2,
    },
    {
      'imagePath': 'images/assets/image5.jpg',
      'name': 'Denim Jacket',
      'category': 'Jackets',
      'description': 'Classic denim jacket for casual wear.',
      'price': 30.0,
      'rating': 4.6,
    },
    {
      'imagePath': 'images/assets/image6.jpg',
      'name': 'Sweater',
      'category': 'Blouses',
      'description': 'A warm and comfortable sweater.',
      'price': 25.0,
      'rating': 4.3,
    },
  ];

  final List<Map<String, dynamic>> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isProductSelected ? selectedProductName : "Women's Tops"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(
                          cart: cart,
                          onClearCart: _clearCart,
                          onRemoveProduct: _removeProduct,
                        )),
              );
            },
          ),
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Horizontal category list
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Main content
          Expanded(
            child: isProductSelected
                ? _buildProductDetailsView()
                : (isGridView
                    ? _buildProductGridView()
                    : _buildProductListView()),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGridView() {
    final filteredProducts = selectedCategory == 'All'
        ? products
        : products
            .where((product) => product['category'] == selectedCategory)
            .toList();

    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return _buildProductCard(filteredProducts[index]);
      },
    );
  }

  Widget _buildProductListView() {
    final filteredProducts = selectedCategory == 'All'
        ? products
        : products
            .where((product) => product['category'] == selectedCategory)
            .toList();

    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return _buildProductCard(filteredProducts[index]);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isProductSelected = true;
          selectedImagePath = product['imagePath'];
          selectedProductName = product['name'];
          selectedProductDescription = product['description'];
          selectedProductPrice = product['price'];
        });
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product['imagePath'],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (product['rating'] ?? 0).floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${product['price'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetailsView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(selectedImagePath,
                width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              selectedProductName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${selectedProductPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(selectedProductDescription, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cart.add({
                        'imagePath': selectedImagePath,
                        'name': selectedProductName,
                        'price': selectedProductPrice,
                      });
                      isProductSelected = false;
                    });
                  },
                  child: Text('Add to Cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isProductSelected = false;
                    });
                  },
                  child: Text('Back to Products'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _clearCart() {
    setState(() {
      cart.clear();
    });
  }

  void _removeProduct(Map<String, dynamic> product) {
    setState(() {
      cart.remove(product);
    });
  }
}
