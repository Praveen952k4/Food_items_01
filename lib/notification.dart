import 'package:flutter/material.dart';
import 'dart:math';

class NotificationPage extends StatelessWidget {
  // Sample data for the orders
  final List<FoodOrder> orders = [
    FoodOrder(
      orderId: '001',
      pickupLat: 40.7128, // Example coordinates (New York)
      pickupLon: -74.0060,
      deliveryLat: 40.730610, // Example coordinates (Another place)
      deliveryLon: -73.935242,
      items: ['Pizza', 'Soda'],
    ),
    FoodOrder(
      orderId: '002',
      pickupLat: 34.0522, // Example coordinates (Los Angeles)
      pickupLon: -118.2437,
      deliveryLat: 34.0522, // Same as pickup
      deliveryLon: -118.2437,
      items: ['Burger', 'Fries'],
    ),
    FoodOrder(
      orderId: '003',
      pickupLat: 51.5074, // Example coordinates (London)
      pickupLon: -0.1278,
      deliveryLat: 51.5074, // Same as pickup
      deliveryLon: -0.1278,
      items: ['Pasta', 'Salad'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final distance = order.calculateDistance();

          return Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 16.0, right: 32, left: 32),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  opacity: 0.8,
                  image: AssetImage(
                    'assets/delivery.png',
                  ),
                ),
                color: const Color.fromARGB(203, 100, 235, 33).withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Order ${order.orderId}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Distance: ${distance.toStringAsFixed(2)} km'),
                    SizedBox(height: 8),
                    Text('Items:'),
                    ...order.items.map((item) => Text('- $item')).toList(),
                  ],
                ),
                trailing: Icon(
                  Icons.directions,
                  color: Colors.red,
                  size: 50,
                ),
                onTap: () {
                  // Handle the tap event (e.g., open order details)
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class FoodOrder {
  final String orderId;
  final double pickupLat;
  final double pickupLon;
  final double deliveryLat;
  final double deliveryLon;
  final List<String> items; // List of food items

  FoodOrder({
    required this.orderId,
    required this.pickupLat,
    required this.pickupLon,
    required this.deliveryLat,
    required this.deliveryLon,
    required this.items,
  });

  // Method to calculate the distance between the pickup and delivery locations
  double calculateDistance() {
    const R = 6371; // Radius of the Earth in km
    double lat1 = pickupLat;
    double lon1 = pickupLon;
    double lat2 = deliveryLat;
    double lon2 = deliveryLon;

    // Convert degrees to radians
    lat1 = lat1 * (3.141592653589793 / 180);
    lon1 = lon1 * (3.141592653589793 / 180);
    lat2 = lat2 * (3.141592653589793 / 180);
    lon2 = lon2 * (3.141592653589793 / 180);

    // Haversine formula
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;
    double a = (sin(dlat / 2) * sin(dlat / 2)) +
        cos(lat1) * cos(lat2) * (sin(dlon / 2) * sin(dlon / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = R * c; // Distance in km
    return distance;
  }
}
