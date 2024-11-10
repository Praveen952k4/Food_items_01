import 'package:flutter/material.dart';
import 'package:food_waste/cart_page.dart';
import 'package:food_waste/chat.dart';
import 'package:food_waste/donation.dart';
import 'package:food_waste/inventory.dart';
import 'package:food_waste/notification.dart';
import 'package:food_waste/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(image: 'assets/child_img.jpg', name: 'Apple'),
    Product(image: 'assets/OIP.jpeg', name: 'Banana'),
    Product(image: 'assets/sakthi.png', name: 'Orange'),
    // Add more products as required
  ];
  List<Product2> products2 = [
    Product2(image: 'assets/child_img.jpg', name: 'Apple'),
    Product2(image: 'assets/OIP.jpeg', name: 'Banana'),
    Product2(image: 'assets/sakthi.png', name: 'Orange'),
    // Add more products as required
  ];

  var totalList = [];
  // Increment count for a specific product
  void incrementCount(int index) {
    setState(() {
      products[index].count++;
      products[index].clicked = true;
    });
  }

  int getTotalItems() {
    int total = 0;
    for (var product in products) {
      total += product.count;
    }
    for (var product in products2) {
      total += product.count;
    }
    return total;
  }

  // Decrement count for a specific product
  void decrementCount(int index) {
    setState(() {
      if (products[index].count > 0) {
        products[index].count--;
      }
    });

    // Increment count for a specific product
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: screenSize.width * 0.6,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      suffixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NotificationPage();
                }));
              },
              child: Icon(Icons.notifications, color: Colors.black),
            ),
            Spacer()
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(203, 100, 235, 33),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SettingsPage();
                })); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(203, 100, 235, 33),
        height: 60,
        shape: const CircularNotchedRectangle(), // This adds notch for FAB
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  // Home button action
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ContactListPage();
                  }));
                },
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return InventoryPage();
                    }));
                  },
                  child: Icon(Icons.inventory_2_outlined)),
              Spacer(
                flex: 8,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_rounded),
                onPressed: () {
                  // Search button action
                  int totalItems = getTotalItems();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CartPage();
                  }));
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(203, 100, 235, 33),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Ensure the button remains round
        ),
        onPressed: () {
          // Center button action
        },
        child: const Icon(
          Icons.home,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // Center the FAB
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Icon(Icons.menu_rounded),
                //     Spacer(),
                //     Container(
                //       width: screenSize.width * 0.7,
                //       decoration: BoxDecoration(
                //         color: Colors.grey[200],
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.only(
                //           left: 8.0,
                //           right: 8.0,
                //         ),
                //         child: TextField(
                //           decoration: InputDecoration(
                //             hintText: ' Search...',
                //             suffixIcon: Icon(Icons.search),
                //             border: InputBorder.none,
                //             contentPadding:
                //                 const EdgeInsets.symmetric(vertical: 15),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     GestureDetector(
                //         onTap: () {
                //           Navigator.of(context)
                //               .push(MaterialPageRoute(builder: (context) {
                //             return NotificationPage();
                //           }));
                //         },
                //         child: Icon(Icons.notifications)),
                //   ],
                // ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's find nearby food",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage('assets/child_img.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.6,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Transform(
                          transform: Matrix4.skewX(-0.3),
                          child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: const Color.fromARGB(203, 100, 235, 33),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DonationsApp();
                                    }));
                                  },
                                  child: Text(
                                    'Donate',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Explore products",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return Container(
                        width: 150,
                        height: 130, // Increased height to fit the content
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/OIP.jpeg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: product.clicked == true
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(96, 0, 0, 0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    topRight: Radius.circular(22),
                                    bottomLeft: Radius.circular(22),
                                    bottomRight: Radius.circular(22),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                      visible: product.clicked,
                                      child: IconButton(
                                        onPressed: () {
                                          decrementCount(index);
                                        },
                                        icon: const Icon(Icons.remove,
                                            color: Colors.white),
                                        iconSize: 20,
                                      ),
                                    ),
                                    Visibility(
                                      visible: product.clicked,
                                      child: Flexible(
                                        child: Container(
                                          width: 40,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Center(
                                            child: Text(
                                              '${product.count}', // This will update the count
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        incrementCount(
                                            index); // Ensure you're calling the function
                                        setState(() {
                                          product.clicked =
                                              true; // Ensure clicked is set to true
                                        });
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Colors.white),
                                      iconSize: 20,
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
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Packed Items",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products2.length,
                    itemBuilder: (context, index) {
                      final product = products2[index];

                      return Container(
                        width: 150,
                        height: 130, // Increased height to fit the content
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 231, 227, 227),
                            image: DecorationImage(
                              image: AssetImage('assets/sakthi.png'),
                              fit: BoxFit.contain,
                              opacity: 0.9,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: products2[index].clicked == true
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(96, 0, 0, 0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    topRight: Radius.circular(22),
                                    bottomLeft: Radius.circular(22),
                                    bottomRight: Radius.circular(22),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                      visible: products2[index].clicked,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            20,
                                          ),
                                        )),
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {
                                              decrementCount2(index);
                                            },
                                            icon: const Icon(Icons.remove,
                                                color: Colors.white),
                                            iconSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: products2[index].clicked,
                                      child: Flexible(
                                        child: Container(
                                          width: 40,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Center(
                                            child: Text(
                                              '${products2[index].count}', // This will update the count

                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        incrementCount2(
                                            index); // Ensure you're calling the function
                                        setState(() {
                                          products2[index].clicked =
                                              true; // Ensure clicked is set to true
                                        });
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Colors.white),
                                      iconSize: 20,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void incrementCount2(int index) {
    setState(() {
      products2[index].count++;
      products2[index].clicked = true;
    });
  }

  // Decrement count for a specific product
  void decrementCount2(int index) {
    setState(() {
      if (products2[index].count > 0) {
        products2[index].count--;
      }
    });
  }
}

class Product {
  final String image;
  final String name;
  int count;
  bool clicked;
  double lat = 0;
  double long = 0;

  Product({
    required this.image,
    required this.name,
    this.count = 0,
    this.clicked = false,
  });
}

class Product2 {
  final String image;
  final String name;
  int count;
  bool clicked;
  double lat = 0;
  double long = 0;

  Product2({
    required this.image,
    required this.name,
    this.count = 0,
    this.clicked = false,
  });
}
