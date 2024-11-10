import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {
      'image': 'assets/images.jpg', // Replace with actual image asset path
      'name': 'Sambar rice',
      'quantity': 2,
      'latitude': 40.7128,
      'longitude': -74.0060,
    },
    {
      'image': 'assets/images.jpg',
      'name': 'Biriyani',
      'quantity': 1,
      'latitude': 34.0522,
      'longitude': -118.2437,
    },
    // Add more items as needed
  ];
  final total = 893.56;

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   color: const Color.fromARGB(203, 100, 235, 33),
      //   height: 60,
      //   shape: const CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Spacer(),
      //       IconButton(icon: const Icon(Icons.message), onPressed: () {}),
      //       Spacer(flex: 8),
      //       IconButton(
      //         icon: const Icon(Icons.shopping_cart_rounded),
      //         onPressed: () {
      //           Navigator.of(context)
      //               .push(MaterialPageRoute(builder: (context) {
      //             return CartPage();
      //           }));
      //         },
      //       ),
      //       Spacer(),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(203, 100, 235, 33),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30),
      //   ),
      //   onPressed: () {
      //     // Center button action
      //   },
      //   child: const Icon(Icons.home),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text('CART'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(item['image']),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                      title: Text(item['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Exp Date : 23/09/2021'),
                          Text('Quantity: ${item['quantity']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          removeItem(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}', // Replace with dynamic total calculation if needed
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add checkout functionality here
              },
              child: Text('Check Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
          ],
        ),
      ),
    );
  }
}
