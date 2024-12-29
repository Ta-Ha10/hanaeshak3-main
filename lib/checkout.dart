import 'package:flutter/material.dart';
import 'package:untitled20/OrderConfirmationScreen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String address = '';
  String contactNumber = '';

  // Function to handle form submission

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 16),

              // Address Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your delivery address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value!;
                },
              ),
              SizedBox(height: 16),

              // Contact Number Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  hintText: 'Enter your contact number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit number';
                  }
                  return null;
                },
                onSaved: (value) {
                  contactNumber = value!;
                },
              ),
              SizedBox(height: 20),

              // Confirm Order Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderConfirmationScreen()),
                  );
                },
                child: Text('Confirm Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
