import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountManagementScreen extends StatefulWidget {
  @override
  _AccountManagementScreenState createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load the current user's data
  void _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _nameController.text = doc['name'] ?? '';
      });
    }
  }

  // Method to validate and update user data in Firestore
  void _validateAndSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final user = _auth.currentUser; // Get the current user here
      if (user != null) {
        // Show a dialog to enter password
        await _promptPassword(context, user);
      }
    }
  }

  // Method to prompt for password and reauthenticate
  Future<void> _promptPassword(BuildContext context, User user) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Verify Password'),
          content: TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                final password = _passwordController.text;
                if (password.isNotEmpty) {
                  try {
                    // Reauthenticate user
                    final authCredential = EmailAuthProvider.credential(
                      email: user.email!,
                      password: password,
                    );
                    await user.reauthenticateWithCredential(authCredential);

                    // Update name in Firestore
                    await _firestore.collection('users').doc(user.uid).update({
                      'name': _nameController.text,
                    });

                    // Show success dialog
                    _showDialog(
                      context,
                      'Account Updated',
                      'Your account information has been updated successfully.',
                    );
                  } catch (e) {
                    _showDialog(
                      context,
                      'Error',
                      'Failed to update account: ${e.toString()}',
                    );
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to show dialog messages
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Management'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Editable Name field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),

                // Save Changes Button
                Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: width / 1.2,
                    height: height / 15,
                    color: Colors.blueAccent,
                    onPressed: () {
                      _validateAndSubmit(context);
                    },
                    child: Text(
                      "Save Changes",
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
