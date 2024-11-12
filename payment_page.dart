import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'payment_Susseccfull.dart'; // Ensure the file exists and is correctly named

class PaymentPage extends StatelessWidget {
  final double totalAmount;

  const PaymentPage({Key? key, required this.totalAmount}) : super(key: key);

  double _calculateGST(double amount) {
    return amount * 0.03;
  }

  // Function to format the amount in Indian numbering system (e.g., 1,00,000)
  String _formatIndianCurrency(double amount) {
    final format = NumberFormat.currency(
      locale: 'en_IN', // Indian locale
      symbol: '₹', // Currency symbol
      decimalDigits: 2, // Two decimal places
    );
    return format.format(amount);
  }

  void _showUPIOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select UPI App'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset('assets/Gpay.png', height: 24, width: 24),
                title: const Text('Google Pay'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle Google Pay payment
                },
              ),
              ListTile(
                leading: Image.asset('assets/phonepe.webp', height: 24, width: 24),
                title: const Text('PhonePe'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle PhonePe payment
                },
              ),
              ListTile(
                leading: Image.asset('assets/Paytm.png', height: 24, width: 24),
                title: const Text('Paytm'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle Paytm payment
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCardDetailsForm(BuildContext context, String cardType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter $cardType Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
                maxLength: 16,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                maxLength: 3,
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle payment with card details
              },
              child: const Text('Pay'),
            ),
          ],
        );
      },
    );
  }

  void _handlePayment(BuildContext context) {
    // Show SnackBar message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Payment Successful!'),
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate to PaymentSuccessful screen after showing the message
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaymentSuccessful()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double gstAmount = _calculateGST(totalAmount);
    final double netAmount = totalAmount + gstAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Credit Card'),
              onTap: () {
                _showCardDetailsForm(context, 'Credit Card');
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Debit Card'),
              onTap: () {
                _showCardDetailsForm(context, 'Debit Card');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('UPI'),
              onTap: () {
                _showUPIOptions(context);
              },
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  _formatIndianCurrency(totalAmount), // Format total amount
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'GST (3%):',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  _formatIndianCurrency(gstAmount), // Format GST amount
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Net Amount:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  _formatIndianCurrency(netAmount), // Format net amount
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _handlePayment(context); // Call the method to show SnackBar and navigate
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
