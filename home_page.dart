import 'package:flutter/material.dart';
import 'package:onlinejewllery/cart_page.dart';
import 'package:onlinejewllery/profile_page.dart'; // Import the profile page
import 'package:onlinejewllery/settings_page.dart'; // Import the settings page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arjun Jewllers',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _cartItems = [];
  String _selectedCategory = 'All';

  List<Map<String, dynamic>> _allFoodItems = [
    {
      'imageUrl': 'assets/dimond1.jpeg',
      'title': 'Diamond Ring',
      'subtitle': 'Woman',
      'rating': 4.9,
      'price': '10,00,000',
      'category': 'Diamond',
    },
    {
      'imageUrl': 'assets/gold2.jpeg',
      'title': 'Gold Nacklace',
      'subtitle': 'Woman',
      'rating': 4.8,
      'price': '30,000',
      'category': 'Gold',
    },
    {
      'imageUrl': 'assets/silver3.jpeg',
      'title': 'Silver eerring',
      'subtitle': 'Woman',
      'rating': 4.5,
      'price': '1,00,000',
      'category': 'Silver',
    },
    {
      'imageUrl': 'assets/dimond2.jpeg',
      'title': 'Diamond Nacklace',
      'subtitle': 'Woman',
      'rating': 4.9,
      'price': '10,00,000',
      'category': 'Diamond',
    },
    {
      'imageUrl': 'assets/gold1.jpeg',
      'title': 'Gold ring',
      'subtitle': 'Woman',
      'rating': 4.8,
      'price': '30,000',
      'category': 'Gold',
    },
    {
      'imageUrl': 'assets/silver1.jpeg',
      'title': 'Silver ring',
      'subtitle': 'Woman',
      'rating': 4.5,
      'price': '1,00,000',
      'category': 'Silver',
    },
    {
      'imageUrl': 'assets/dimond3.jpeg',
      'title': 'Diamond eerring',
      'subtitle': 'Woman',
      'rating': 4.9,
      'price': '10,00,000',
      'category': 'Diamond',
    },
    {
      'imageUrl': 'assets/gold3.jpeg',
      'title': 'Gold eerring',
      'subtitle': 'Woman',
      'rating': 4.8,
      'price': '30,000',
      'category': 'Gold',
    },
    {
      'imageUrl': 'assets/silver2.jpeg',
      'title': 'Silver Nacklace',
      'subtitle': 'Woman',
      'rating': 4.5,
      'price': '1,00,000',
      'category': 'Silver',
    },
    {
      'imageUrl': 'assets/dimond4.jpeg',
      'title': 'Diamond bracelet',
      'subtitle': 'Woman',
      'rating': 4.9,
      'price': '10,00,000',
      'category': 'Diamond',
    },
    {
      'imageUrl': 'assets/gold4.jpeg',
      'title': 'Gold bracelet',
      'subtitle': 'Woman',
      'rating': 4.8,
      'price': '30,000',
      'category': 'Gold',
    },
    {
      'imageUrl': 'assets/silver4.jpeg',
      'title': 'Silver bracelet',
      'subtitle': 'Woman',
      'rating': 4.5,
      'price': '1,00,000',
      'category': 'Silver',
    },
  ];

  List<Map<String, dynamic>> _filteredFoodItems = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredFoodItems = _allFoodItems;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage(cartItems: _cartItems)),
        );
      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      }
    });
  }

  void _addToCart(Map<String, dynamic> foodItem) {
    setState(() {
      _cartItems.add(foodItem);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${foodItem['title']} added to cart!'),
        duration: const Duration(seconds: 2),
      ),
    );

    print('Added to cart: $foodItem');
  }

  void _filterFoodItems(String query) {
    final filteredItems = _allFoodItems.where((item) {
      final titleLower = item['title'].toLowerCase();
      final subtitleLower = item['subtitle'].toLowerCase();
      final queryLower = query.toLowerCase();

      return titleLower.contains(queryLower) || subtitleLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredFoodItems = filteredItems;
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredFoodItems = _allFoodItems;
      } else {
        _filteredFoodItems = _allFoodItems.where((item) => item['category'] == category).toList();
      }
    });
  }

  void _showImageDetailsDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                child: Image.asset(
                  item['imageUrl'],
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['subtitle'],
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: ₹${item['price']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          item['rating'].toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _addToCart(item);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF03A9F4),
          automaticallyImplyLeading: false,
          title: const Text('Arjun Jewllers', style: TextStyle(fontSize: 40)),
          centerTitle: true,
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Navigate to settings page or perform an action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  'Arjun Jewllers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              ListTile(
              leading: const Icon(Icons.settings),focusColor: Colors.deepOrangeAccent,
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()), // Navigate to SettingsPage
                );
              },
            ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // Implement logout functionality here
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: _filterFoodItems,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _filterByCategory('All');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text('All', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _filterByCategory('Diamond');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text('Diamond', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _filterByCategory('Silver');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text('Silver', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _filterByCategory('Gold');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text('Gold', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // 1 item per row (full width)
                  childAspectRatio: 1.10, // Decrease to make items taller
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _filteredFoodItems.length,
                itemBuilder: (context, index) {
                  final foodItem = _filteredFoodItems[index];
                  return GestureDetector(
                    onTap: () {
                      _showImageDetailsDialog(context, foodItem);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          // Display the image at the top
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              foodItem['imageUrl'],
                              height: 250, // Increase the height for a larger image
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Display the title and price
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foodItem['title'],
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Price: ₹${foodItem['price']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),

                                // Row for Rating and Add to Cart Icon
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Rating Section
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.orange, size: 18),
                                        const SizedBox(width: 4),
                                        Text(
                                          foodItem['rating'].toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),

                                    // Add to Cart Button
                                    IconButton(
                                      icon: const Icon(Icons.add_shopping_cart),
                                      color: Colors.blue, // Change the color as needed
                                      onPressed: () {
                                        _addToCart(foodItem);
                                      },
                                    ),
                                  ],
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
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
