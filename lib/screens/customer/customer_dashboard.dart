import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';

class CustomerDashboard extends StatelessWidget {
  CustomerDashboard({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Get.offAllNamed('/customer');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Obx(() {
        final user = authController.currentUser.value;

        if (user == null) {
          return const Center(child: Text("Loading..."));
        }

        return Column(
          children: [
            // Welcome Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.greenAccent],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 35, color: Colors.green),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome, ${user.fullName}!",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "University: ${user.university ?? 'N/A'}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoTile("Total Trips", "0"),
                        _buildInfoTile("Next Trip", "None"),
                        _buildInfoTile("Points", "0"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    _buildMenuItem(
                      title: "Book a Ride",
                      icon: Icons.book_online,
                      color: Colors.blue,
                      onTap: () => Get.to(() => BookRideScreen()),
                    ),
                    _buildMenuItem(
                      title: "My Trips",
                      icon: Icons.history,
                      color: Colors.green,
                      onTap: () => Get.to(() => MyTripsScreen()),
                    ),
                    _buildMenuItem(
                      title: "Track Van",
                      icon: Icons.location_on,
                      color: Colors.red,
                      onTap: () => Get.to(() => TrackVanScreen()),
                    ),
                    _buildMenuItem(
                      title: "Available Routes",
                      icon: Icons.map,
                      color: Colors.orange,
                      onTap: () => Get.to(() => AvailableRoutesScreen()),
                    ),
                    _buildMenuItem(
                      title: "Notifications",
                      icon: Icons.notifications,
                      color: Colors.purple,
                      onTap: () => Get.to(() => NotificationsScreen()),
                    ),
                    _buildMenuItem(
                      title: "Support",
                      icon: Icons.support_agent,
                      color: Colors.teal,
                      onTap: () => Get.to(() => SupportScreen()),
                    ),
                    _buildMenuItem(
                      title: "Owner Payment Details",
                      icon: Icons.payment,
                      color: Colors.amber,
                      onTap: () => Get.to(() => OwnerPaymentDetailsScreen()),
                    ),
                    _buildMenuItem(
                      title: "Profile",
                      icon: Icons.person,
                      color: Colors.grey,
                      onTap: () => Get.to(() => CustomerProfileScreen(user: user)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ CUSTOMER SUB-SCREENS ============

class BookRideScreen extends StatelessWidget {
  final List<Map<String, dynamic>> routes = [
    {"from": "University", "to": "City Center", "price": 50, "time": "8:30 AM"},
    {"from": "City Center", "to": "University", "price": 50, "time": "5:30 PM"},
    {"from": "University", "to": "Bus Stand", "price": 40, "time": "9:00 AM"},
    {"from": "Bus Stand", "to": "University", "price": 40, "time": "6:00 PM"},
    {"from": "University", "to": "Market", "price": 35, "time": "10:00 AM"},
    {"from": "Market", "to": "University", "price": 35, "time": "7:00 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book a Ride")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.route, color: Colors.blue),
              ),
              title: Text("${route['from']} → ${route['to']}"),
              subtitle: Text("🕐 ${route['time']} • Rs. ${route['price']}"),
              trailing: ElevatedButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text("Confirm Booking"),
                      content: Text("Book ride from ${route['from']} to ${route['to']}?"),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.snackbar(
                              "Success",
                              "Ride booked successfully!",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                          child: const Text("Confirm"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Book", style: TextStyle(fontSize: 12)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyTripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Trips")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Text("${index + 1}"),
              ),
              title: Text("Trip #${DateTime.now().millisecondsSinceEpoch % 10000}"),
              subtitle: Text("Dec ${15 - index}, 2024 • University → City Center"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Rs. 50", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Completed", style: TextStyle(fontSize: 10, color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrackVanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Van")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              "Van Location Tracking",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Your van is currently:"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "📍 2 km away • Arriving in 5 min",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
              label: const Text("Refresh Location"),
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableRoutesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> routes = [
    {"name": "University Express", "stops": 5, "time": "30 min", "price": 50},
    {"name": "City Circular", "stops": 8, "time": "45 min", "price": 60},
    {"name": "Market Link", "stops": 4, "time": "25 min", "price": 40},
    {"name": "Suburban Route", "stops": 10, "time": "60 min", "price": 80},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Routes")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.route, color: Colors.orange),
              title: Text(route['name']),
              subtitle: Text("${route['stops']} stops • ${route['time']} • ₹${route['price']}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.to(() => RouteDetailsScreen(route: route));
              },
            ),
          );
        },
      ),
    );
  }
}

class RouteDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> route;

  const RouteDetailsScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(route['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow("Route Name", route['name']),
                    _buildDetailRow("Total Stops", route['stops'].toString()),
                    _buildDetailRow("Duration", route['time']),
                    _buildDetailRow("Fare", "Rs. ${route['price']}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar("Success", "Route selected! Go to Book a Ride.");
                },
                child: const Text("Select This Route"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {"title": "Ride Confirmed", "message": "Your ride to University is confirmed", "time": "5 min ago", "read": false},
    {"title": "Payment Success", "message": "Rs. 50 paid successfully", "time": "1 hour ago", "read": false},
    {"title": "New Route Added", "message": "New express route available", "time": "1 day ago", "read": true},
    {"title": "Wallet Update", "message": "Rs. 100 added to wallet", "time": "2 days ago", "read": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Card(
            color: notif['read'] == false ? Colors.blue.shade50 : null,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: notif['read'] == false ? Colors.blue : Colors.grey.shade300,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text(notif['title'], style: TextStyle(fontWeight: notif['read'] == false ? FontWeight.bold : FontWeight.normal)),
              subtitle: Text(notif['message']),
              trailing: Text(notif['time'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }
}

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Support")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("Call Support"),
                subtitle: const Text("+92 304 7098923"),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: const Text("Email Support"),
                subtitle: const Text("support@smarttransport.com"),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.chat, color: Colors.orange),
                title: const Text("Live Chat"),
                subtitle: const Text("Available 7 AM - 6 PM"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "FAQ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Card(
              child: ExpansionTile(
                title: const Text("How to book a ride?"),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Go to Book a Ride, select your route, and confirm booking."),
                  ),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                title: const Text("How to track my van?"),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Use Track Van feature to see real-time location."),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OwnerPaymentDetailsScreen extends StatelessWidget {
  OwnerPaymentDetailsScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  UserModel? getMyOwner() {
    final customer = authController.currentUser.value;

    if (customer == null || customer.ownerId == null) {
      return null;
    }

    final owners = authController.getAllOwners();

    try {
      return owners.firstWhere(
            (owner) => owner.generatedOwnerId == customer.ownerId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final owner = getMyOwner();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Payment Details"),
        centerTitle: true,
      ),
      body: owner == null
          ? const Center(
        child: Text(
          "No owner details found.\nPlease check your Owner ID.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.business, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          "Owner / Company Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 25),

                    _buildRow("Company", owner.businessName ?? "N/A"),
                    _buildRow("Owner Name", owner.fullName),
                    _buildRow("Business Location", owner.address ?? "N/A"),
                    _buildRow("Phone 1", owner.phone),
                    _buildRow("Phone 2", owner.phone2 ?? "N/A"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          "Pay To Owner",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 25),

                    _buildRow(
                      "JazzCash / Easypaisa",
                      owner.jazzCashNumber ?? "N/A",
                    ),
                    _buildRow(
                      "Bank Account",
                      owner.bankAccount ?? "N/A",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "After payment, inform the owner. Your booking will remain pending until the owner confirms the payment.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class CustomerProfileScreen extends StatelessWidget {
  final UserModel user;

  const CustomerProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text(user.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            _buildInfoRow("Phone", user.phone),
            _buildInfoRow("University", user.university ?? 'N/A'),
            _buildInfoRow("Owner ID", user.ownerId ?? 'N/A'),
            _buildInfoRow("Member Since", "Dec 2024"),
            _buildInfoRow("Total Trips", "0"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value),
      ),
    );
  }
}








