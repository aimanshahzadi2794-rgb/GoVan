import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';

// ============ OWNER DASHBOARD ============

class OwnerDashboard extends StatelessWidget {
  OwnerDashboard({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Get.offAllNamed('/owner');
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
        final customers = authController.getMyCustomers();

        if (user == null) {
          return const Center(child: Text("Loading..."));
        }

        return Column(
          children: [
            // Welcome Card with Owner ID
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
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
                        child: Icon(Icons.business, size: 35, color: Colors.blue),
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
                            const SizedBox(height: 4),
                            Text(
                              "Business: ${user.businessName ?? 'N/A'}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
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
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Your Owner ID",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Get.snackbar(
                              "Owner ID Copied!",
                              user.generatedOwnerId ?? 'N/A',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              user.generatedOwnerId ?? 'N/A',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Tap to copy | Share with customers",
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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
                        _buildInfoTile("Total Customers", customers.length.toString()),
                        _buildInfoTile("Total Rides", "0"),
                        _buildInfoTile("Earnings", "Rs. 0"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Management",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

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
                      title: "Routes",
                      icon: Icons.map,
                      color: Colors.blue,
                      onTap: () => Get.to(() => OwnerRoutesScreen()),
                    ),
                    _buildMenuItem(
                      title: "Manage Vans",
                      icon: Icons.directions_bus,
                      color: Colors.green,
                      onTap: () => Get.to(() => OwnerVansScreen()),
                    ),
                    _buildMenuItem(
                      title: "Customers",
                      icon: Icons.people,
                      color: Colors.orange,
                      onTap: () => Get.to(() => OwnerCustomersScreen(customers: customers)),
                    ),
                    _buildMenuItem(
                      title: "Trips",
                      icon: Icons.timeline,
                      color: Colors.purple,
                      onTap: () => Get.to(() => OwnerTripsScreen()),
                    ),
                    _buildMenuItem(
                      title: "Earnings",
                      icon: Icons.money,
                      color: Colors.amber,
                      onTap: () => Get.to(() => OwnerEarningsScreen()),
                    ),
                    _buildMenuItem(
                      title: "Profile",
                      icon: Icons.person,
                      color: Colors.grey,
                      onTap: () => Get.to(() => OwnerProfileScreen(user: user)),
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
            fontSize: 24,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ ROUTE MODEL ============

class RouteModel {
  String id;
  String routeName;
  String from;
  String to;
  String distance;
  String duration;
  String price;
  List<String> stops;
  bool isActive;

  RouteModel({
    required this.id,
    required this.routeName,
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    required this.price,
    required this.stops,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routeName': routeName,
      'from': from,
      'to': to,
      'distance': distance,
      'duration': duration,
      'price': price,
      'stops': stops,
      'isActive': isActive,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'],
      routeName: map['routeName'],
      from: map['from'],
      to: map['to'],
      distance: map['distance'],
      duration: map['duration'],
      price: map['price'],
      stops: List<String>.from(map['stops'] ?? []),
      isActive: map['isActive'] ?? true,
    );
  }
}

// ============ ROUTES CONTROLLER ============

class RoutesController extends GetxController {
  final box = GetStorage();
  var routes = <RouteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRoutes();
  }

  void loadRoutes() {
    List<dynamic> savedRoutes = box.read('routes') ?? [];
    routes.value = savedRoutes.map((r) => RouteModel.fromMap(r)).toList();
  }

  void addRoute(RouteModel route) {
    List<dynamic> savedRoutes = box.read('routes') ?? [];
    savedRoutes.add(route.toMap());
    box.write('routes', savedRoutes);
    loadRoutes();
  }

  void updateRoute(RouteModel route) {
    List<dynamic> savedRoutes = box.read('routes') ?? [];
    int index = savedRoutes.indexWhere((r) => r['id'] == route.id);
    if (index != -1) {
      savedRoutes[index] = route.toMap();
      box.write('routes', savedRoutes);
      loadRoutes();
    }
  }

  void deleteRoute(String id) {
    List<dynamic> savedRoutes = box.read('routes') ?? [];
    savedRoutes.removeWhere((r) => r['id'] == id);
    box.write('routes', savedRoutes);
    loadRoutes();
  }
}

// ============ OWNER ROUTES SCREEN ============

class OwnerRoutesScreen extends StatelessWidget {
  OwnerRoutesScreen({super.key});

  final RoutesController routesController = Get.put(RoutesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Routes"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (routesController.routes.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.route, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  "No Routes Added Yet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Tap + button to add your first route",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: routesController.routes.length,
          itemBuilder: (context, index) {
            final route = routesController.routes[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.route, color: Colors.blue),
                ),
                title: Text(
                  route.routeName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${route.from} → ${route.to}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        _showRouteDialog(context, route: route);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmation(context, route.id);
                      },
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Distance", route.distance),
                        _buildDetailRow("Duration", route.duration),
                        _buildDetailRow("Price", "Rs. ${route.price}"),
                        _buildDetailRow("Stops", route.stops.join(" → ")),
                        _buildDetailRow("Status", route.isActive ? "Active" : "Inactive"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRouteDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showRouteDialog(BuildContext context, {RouteModel? route}) {
    final isEditing = route != null;
    final nameController = TextEditingController(text: route?.routeName ?? '');
    final fromController = TextEditingController(text: route?.from ?? '');
    final toController = TextEditingController(text: route?.to ?? '');
    final distanceController = TextEditingController(text: route?.distance ?? '');
    final durationController = TextEditingController(text: route?.duration ?? '');
    final priceController = TextEditingController(text: route?.price ?? '');
    final stopsController = TextEditingController(text: route?.stops.join(", ") ?? '');
    bool isActive = route?.isActive ?? true;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxHeight: 500),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing ? "Edit Route" : "Add New Route",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(nameController, "Route Name", Icons.route),
                    const SizedBox(height: 12),
                    _buildTextField(fromController, "From (Starting Point)", Icons.location_on),
                    const SizedBox(height: 12),
                    _buildTextField(toController, "To (Destination)", Icons.flag),
                    const SizedBox(height: 12),
                    _buildTextField(distanceController, "Distance (e.g., 5 km)", Icons.straighten),
                    const SizedBox(height: 12),
                    _buildTextField(durationController, "Duration (e.g., 15 min)", Icons.timer),
                    const SizedBox(height: 12),
                    _buildTextField(priceController, "Price (Rs.)", Icons.money),
                    const SizedBox(height: 12),
                    _buildTextField(stopsController, "Stops (comma separated)", Icons.list_alt),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: isActive,
                          onChanged: (val) {
                            setState(() {
                              isActive = val ?? true;
                            });
                          },
                        ),
                        const Text("Route Active"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (nameController.text.isEmpty ||
                                  fromController.text.isEmpty ||
                                  toController.text.isEmpty) {
                                Get.snackbar("Error", "Please fill required fields");
                                return;
                              }

                              final stops = stopsController.text
                                  .split(',')
                                  .map((s) => s.trim())
                                  .where((s) => s.isNotEmpty)
                                  .toList();

                              if (isEditing) {
                                final updatedRoute = RouteModel(
                                  id: route!.id,
                                  routeName: nameController.text,
                                  from: fromController.text,
                                  to: toController.text,
                                  distance: distanceController.text,
                                  duration: durationController.text,
                                  price: priceController.text,
                                  stops: stops,
                                  isActive: isActive,
                                );
                                routesController.updateRoute(updatedRoute);
                                Get.snackbar("Success", "Route updated successfully");
                              } else {
                                final newRoute = RouteModel(
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  routeName: nameController.text,
                                  from: fromController.text,
                                  to: toController.text,
                                  distance: distanceController.text,
                                  duration: durationController.text,
                                  price: priceController.text,
                                  stops: stops,
                                  isActive: isActive,
                                );
                                routesController.addRoute(newRoute);
                                Get.snackbar("Success", "Route added successfully");
                              }
                              Get.back();
                            },
                            child: Text(isEditing ? "Update" : "Add Route"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String routeId) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Route"),
        content: const Text("Are you sure you want to delete this route?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              routesController.deleteRoute(routeId);
              Get.back();
              Get.snackbar("Success", "Route deleted successfully");
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ============ OTHER SCREENS (Keep as is or modify as needed) ============

class OwnerVansScreen extends StatelessWidget {
  final box = GetStorage();
  var vans = <Map<String, dynamic>>[].obs;

  @override
  Widget build(BuildContext context) {
    loadVans();

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Vans")),
      body: Obx(() {
        if (vans.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_bus, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text("No Vans Added Yet"),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: vans.length,
          itemBuilder: (context, index) {
            final van = vans[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.directions_bus, color: Colors.green),
                title: Text(van['name']),
                subtitle: Text("License: ${van['license']} • Capacity: ${van['capacity']} seats"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _showVanDialog(context, van: van, index: index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteVan(index),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showVanDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void loadVans() {
    vans.value = List<Map<String, dynamic>>.from(box.read('vans') ?? []);
  }

  void _showVanDialog(BuildContext context, {Map<String, dynamic>? van, int? index}) {
    final isEditing = van != null;
    final nameController = TextEditingController(text: van?['name'] ?? '');
    final licenseController = TextEditingController(text: van?['license'] ?? '');
    final capacityController = TextEditingController(text: van?['capacity']?.toString() ?? '');

    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isEditing ? "Edit Van" : "Add New Van"),
              const SizedBox(height: 16),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Van Name")),
              const SizedBox(height: 12),
              TextField(controller: licenseController, decoration: const InputDecoration(labelText: "License Plate")),
              const SizedBox(height: 12),
              TextField(controller: capacityController, decoration: const InputDecoration(labelText: "Seating Capacity"), keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Get.back(), child: const Text("Cancel"))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final newVan = {
                          'name': nameController.text,
                          'license': licenseController.text,
                          'capacity': int.tryParse(capacityController.text) ?? 0,
                        };

                        if (isEditing) {
                          vans[index!] = newVan;
                        } else {
                          vans.add(newVan);
                        }
                        box.write('vans', vans);
                        Get.back();
                        Get.snackbar("Success", isEditing ? "Van updated" : "Van added");
                      },
                      child: Text(isEditing ? "Update" : "Add"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteVan(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Van"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              vans.removeAt(index);
              GetStorage().write('vans', vans);
              Get.back();
              Get.snackbar("Success", "Van deleted");
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class OwnerCustomersScreen extends StatelessWidget {
  final List<UserModel> customers;

  const OwnerCustomersScreen({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Customers")),
      body: customers.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text("No customers yet!"),
            SizedBox(height: 8),
            Text("Share your Owner ID to get customers"),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(customer.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.email),
                  Text(customer.phone),
                  Text(customer.university ?? 'Student'),
                ],
              ),
              trailing: Chip(
                label: Text(customer.university?.substring(0, 3) ?? 'STU'),
                backgroundColor: Colors.blue.shade100,
              ),
            ),
          );
        },
      ),
    );
  }
}

class OwnerTripsScreen extends StatelessWidget {
  final box = GetStorage();
  var trips = <Map<String, dynamic>>[].obs;

  @override
  Widget build(BuildContext context) {
    loadTrips();
    return Scaffold(
      appBar: AppBar(title: const Text("Trip History")),
      body: Obx(() {
        if (trips.isEmpty) {
          return const Center(child: Text("No trips yet"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: trips.length,
          itemBuilder: (context, index) {
            final trip = trips[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(trip['id']?.toString() ?? "${index + 1}"),
                ),
                title: Text(trip['routeName'] ?? "Trip #${trip['id']}"),
                subtitle: Text("${trip['date']} • ${trip['passengers']} passengers • Rs. ${trip['amount']}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            );
          },
        );
      }),
    );
  }

  void loadTrips() {
    trips.value = List<Map<String, dynamic>>.from(box.read('owner_trips') ?? []);
  }
}

class OwnerEarningsScreen extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final totalEarnings = box.read('total_earnings') ?? 45250;
    final thisMonth = box.read('this_month_earnings') ?? 12500;
    final lastMonth = box.read('last_month_earnings') ?? 10200;

    return Scaffold(
      appBar: AppBar(title: const Text("Earnings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("Total Earnings", style: TextStyle(color: Colors.grey)),
                    Text("Rs. $totalEarnings", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildEarningStat("This Month", "Rs. $thisMonth"),
                        _buildEarningStat("Last Month", "Rs. $lastMonth"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Recent Transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.payment, color: Colors.green),
                    title: Text("Trip #${1000 + index}"),
                    subtitle: Text("Dec ${15 - index}, 2024"),
                    trailing: Text("+Rs. ${250 + index * 50}", style: const TextStyle(color: Colors.green)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningStat(String label, String amount) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(amount, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class OwnerProfileScreen extends StatelessWidget {
  final UserModel user;

  const OwnerProfileScreen({super.key, required this.user});

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
              child: Icon(Icons.business, size: 50),
            ),
            const SizedBox(height: 16),
            Text(user.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            _buildInfoRow("Business Name", user.businessName ?? 'N/A'),
            _buildInfoRow("Phone", user.phone),
            _buildInfoRow("Owner ID", user.generatedOwnerId ?? 'N/A'),
            _buildInfoRow("Total Customers", "0"),
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









