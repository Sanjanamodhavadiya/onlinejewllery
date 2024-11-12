import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for formatting
import 'payment_page.dart'; // Import your PaymentPage here

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Function to parse price string into an integer value
  int _parsePrice(String price) {
    return int.parse(price.replaceAll(',', ''));
  }

  // Function to calculate the total price of items in the cart
  num _calculateTotalPrice() {
    num total = 0; // Change type to num
    for (var item in widget.cartItems) {
      total += item['totalPrice'] ?? _parsePrice(item['price']);
    }
    return total;
  }

  // Function to format numbers in the Indian number system
  String _formatIndianCurrency(num amount) {
    final format = NumberFormat.currency(
      locale: 'en_IN', // Indian locale
      symbol: '₹', // Currency symbol
      decimalDigits: 0, // No decimal places
    );
    return format.format(amount);
  }

  // Function to increase the quantity of a cart item
  void _increaseQuantity(String title) {
    setState(() {
      for (var item in widget.cartItems) {
        if (item['title'] == title) {
          item['quantity'] = (item['quantity'] ?? 0) + 1; // Use 0 if quantity is null
          item['totalPrice'] = (item['totalPrice'] ?? _parsePrice(item['price'])) + _parsePrice(item['price']);
          break;
        }
      }
    });
  }

  // Function to decrease the quantity of a cart item
  void _decreaseQuantity(String title) {
    setState(() {
      for (var item in widget.cartItems) {
        if (item['title'] == title) {
          if (item['quantity'] != null && item['quantity'] > 1) {
            item['quantity'] = item['quantity'] - 1;
            item['totalPrice'] = item['totalPrice'] - _parsePrice(item['price']);
          } else {
            _removeItem(title);
          }
          break;
        }
      }
    });
  }

  // Function to remove an item from the cart
  void _removeItem(String title) {
    setState(() {
      widget.cartItems.removeWhere((item) => item['title'] == title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          var item = widget.cartItems[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(8.0),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(item['subtitle']),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 4),
                            Text(item['rating'].toString()),
                          ],
                        ),
                        Text(
                          'Price: ₹${item['price']}',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Total: ₹${item['totalPrice'] ?? item['price']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Quantity: ${item['quantity'] ?? 1}', // Display quantity
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                _decreaseQuantity(item['title']);
                              },
                            ),
                            Text(item['quantity']?.toString() ?? '1'),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                _increaseQuantity(item['title']);
                              },
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            _removeItem(item['title']);
                          },
                          child: Text("Remove"),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: ${_formatIndianCurrency(_calculateTotalPrice())}',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                double totalPrice = _calculateTotalPrice().toDouble(); // Convert to double

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(totalAmount: totalPrice), // Pass total amount
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),backgroundColor: Color(0xFF4CAF50)
              ),
              child: Text(
                'Proceed to Payment',
                style: TextStyle(fontSize: 25,color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
