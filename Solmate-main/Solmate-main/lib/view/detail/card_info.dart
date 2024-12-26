import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sneakers_app/view/home/home_screen.dart';
import 'package:sneakers_app/view/home/home_screen.dart';
import 'package:sneakers_app/view/view.dart';
import '../../utils/constants.dart';
import '../home/home_screen.dart';

class CardInfoScreen extends StatefulWidget {
  @override
  _CardInfoScreenState createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  // Validation and Submission Method
  void _validateAndSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Show confirmation popup
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Order Placed'),
            content: Text('Your order has been placed. You will receive a confirmation email soon.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.off(() => HomeScreen());
                  // Navigate to Home Screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,  // Add Form key
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Holder Name
                TextFormField(
                  controller: _cardHolderNameController,
                  decoration: InputDecoration(
                    labelText: 'Card Holder Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card holder\'s name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
            
                // Card Number
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 16) {
                      return 'Please enter a valid 16-digit card number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
            
                // Expiry Date
                TextFormField(
                  controller: _expiryDateController,
                  decoration: InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty || !RegExp(r'(0[1-9]|1[0-2])\/\d{2}').hasMatch(value)) {
                      return 'Please enter a valid expiry date in MM/YY format';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
            
                // CVC
                TextFormField(
                  controller: _cvcController,
                  decoration: InputDecoration(
                    labelText: 'CVC',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 3) {
                      return 'Please enter a valid 3-digit CVC';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
            
                // Submit Button
                Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: width / 1.2,
                    height: height / 15,
                    color: AppConstantsColor.materialButtonColor,
                    onPressed: () {
                      _validateAndSubmit(context);
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
