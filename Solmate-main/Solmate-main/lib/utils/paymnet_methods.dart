import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth for getting the user email
import 'package:sneakers_app/view/detail/card_info.dart';
import '../../../theme/custom_app_theme.dart';
import '../../../utils/constants.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // This will import Hmac and other cryptographic functions.
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';  // Add this import
import 'package:http/http.dart' as http;

// Payment Mode Screen
class PaymentModeScreen extends StatefulWidget {
  const PaymentModeScreen({Key? key}) : super(key: key);

  @override
  _PaymentModeScreenState createState() => _PaymentModeScreenState();
}

class _PaymentModeScreenState extends State<PaymentModeScreen> {
  String _selectedPaymentMode = 'Cash on Delivery'; // Default selection
  String? _selectedOnlinePaymentMethod;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String userEmail; // Store user's email

  @override
  void initState() {
    super.initState();
    _getUserEmail(); // Get user email on initialization
  }

  Future<void> _getUserEmail() async {
    User? user = _auth.currentUser;
    if (user != null) {
      userEmail = user.email ?? 'unknown';
    } else {
      userEmail = 'unknown';
    }
  }

  payment() async {
    var digest;
    String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String dexpiredate = DateFormat("yyyyMMddHHmmss").format(DateTime.now().add(Duration(days: 1)));
    String tre = "T" + dateandtime;
    String pp_Amount = "100000";
    String pp_BillReference = "billRef";
    String pp_Description = "Description";
    String pp_Language = "EN";
    String pp_MerchantID = "MC146864"; // Your Merchant ID
    String pp_Password = "2ztwszwye5"; // Your Password
    String pp_ReturnURL = "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    String pp_ver = "1.1";
    String pp_TxnCurrency = "PKR";
    String pp_TxnDateTime = dateandtime.toString();
    String pp_TxnExpiryDateTime = dexpiredate.toString();
    String pp_TxnRefNo = tre.toString();
    String pp_TxnType = "MWALLET";
    String ppmpf_1 = "4456733833993";
    String IntegeritySalt = "2bd22v2c7z"; // Your Integerity Salt
    String and = '&';
    String superdata = IntegeritySalt + and +
        pp_Amount + and +
        pp_BillReference + and +
        pp_Description + and +
        pp_Language + and +
        pp_MerchantID + and +
        pp_Password + and +
        pp_ReturnURL + and +
        pp_TxnCurrency + and +
        pp_TxnDateTime + and +
        pp_TxnExpiryDateTime + and +
        pp_TxnRefNo + and +
        pp_TxnType + and +
        pp_ver + and +
        ppmpf_1;

    var key = utf8.encode(IntegeritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = new Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);
    var url = 'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

    var response = await http.post(Uri.parse(url), body: {
      "pp_Version": pp_ver,
      "pp_TxnType": pp_TxnType,
      "pp_Language": pp_Language,
      "pp_MerchantID": pp_MerchantID,
      "pp_Password": pp_Password,
      "pp_TxnRefNo": tre,
      "pp_Amount": pp_Amount,
      "pp_TxnCurrency": pp_TxnCurrency,
      "pp_TxnDateTime": dateandtime,
      "pp_BillReference": pp_BillReference,
      "pp_Description": pp_Description,
      "pp_TxnExpiryDateTime": dexpiredate,
      "pp_ReturnURL": pp_ReturnURL,
      "pp_SecureHash": sha256Result.toString(),
      "ppmpf_1": "4456733833993"
    });

    print("response=>");
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Modes", style: AppThemes.bagTitle),
        // backgroundColor: AppConstantsColor.darkTextColor,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose Payment Mode", style: AppThemes.bagTitle),
            SizedBox(height: height * 0.02),

            // Cash on Delivery Option
            ListTile(
              title: Text("Cash on Delivery", style: AppThemes.bagProductModel),
              leading: Radio<String>(
                value: 'Cash on Delivery',
                groupValue: _selectedPaymentMode,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMode = value!;
                    _selectedOnlinePaymentMethod = null; // Reset online payment selection
                  });
                },
                activeColor: AppConstantsColor.materialButtonColor,
              ),
            ),

            // Online Payment Option
            ListTile(
              title: Text("Online Payment", style: AppThemes.bagProductModel),
              leading: Radio<String>(
                value: 'Online Payment',
                groupValue: _selectedPaymentMode,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMode = value!;
                  });
                },
                activeColor: AppConstantsColor.materialButtonColor,
              ),
            ),

            // Show JazzCash option only if Online Payment is selected
            if (_selectedPaymentMode == 'Online Payment') ...[
              SizedBox(height: height * 0.02),
              Text("Select Online Payment Method", style: AppThemes.bagTitle),
              ListTile(
                title: Text("JazzCash", style: AppThemes.bagProductModel),
                leading: Radio<String>(
                  value: 'JazzCash',
                  groupValue: _selectedOnlinePaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedOnlinePaymentMethod = value!;
                    });
                  },
                  activeColor: AppConstantsColor.materialButtonColor,
                ),
              ),
            ],

            // Confirm Button
            Spacer(),
            Center(
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                minWidth: width * 0.8,
                height: height / 15,
                color: AppConstantsColor.materialButtonColor,
                onPressed: () {
                  // Handle confirmation action (e.g. move to the next screen)
                  _confirmPayment();
                },
                child: Text(
                  "CONFIRM",
                  style: TextStyle(color: AppConstantsColor.lightTextColor),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  void _confirmPayment() async {
    String paymentInfo = _selectedPaymentMode;
    if (_selectedPaymentMode == 'Online Payment' && _selectedOnlinePaymentMethod != null) {
      paymentInfo += " with $_selectedOnlinePaymentMethod";
    }

    try {
      // Save order details to Firestore
      await _firestore.collection('orders').add({
        'userEmail': userEmail,
        'paymentMode': _selectedPaymentMode,
        'onlinePaymentMethod': _selectedOnlinePaymentMethod ?? '',
        'orderTime': FieldValue.serverTimestamp(), // Store timestamp
      });

      // If JazzCash is selected, call payment function
      if (_selectedPaymentMode == 'Online Payment' && _selectedOnlinePaymentMethod == 'JazzCash') {
        await payment();
      }

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Payment Confirmation'),
            content: Text('You have selected: $paymentInfo\nOrder saved for tracking.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardInfoScreen()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Show error message if saving fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to save your order. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

// Another Screen with navigation to PaymentModeScreen
class SomeOtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Some Other Screen"),
      ),
      body: Center(
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          minWidth: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height / 15,
          color: Colors.blue, // Change to your button color
          onPressed: () {
            // Navigate to the PaymentModeScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentModeScreen()),
            );
          },
          child: Text(
            "Go to Payment Screen",
            style: TextStyle(color: Colors.white), // Change to your text color
          ),
        ),
      ),
    );
  }
}

