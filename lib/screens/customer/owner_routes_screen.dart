import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transport_controller.dart';
import '../../models/owner_model.dart';

class OwnerRoutesScreen extends StatelessWidget {
  OwnerRoutesScreen({
    super.key,
    required this.owner,
  });

  final OwnerModel owner;
  final TransportController controller = Get.find<TransportController>();

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();

  void showBookingDialog(String routeName) {
    Get.defaultDialog(
      title: 'Book Seat',
      content: Column(
        children: [
          TextField(
            controller: customerNameController,
            decoration: const InputDecoration(
              labelText: 'Customer Name',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: customerPhoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Customer Phone',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          Text(
            'Pay manually to owner:\nJazzCash: ${owner.jazzCashNumber}\nBank: ${owner.bankAccount}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      textConfirm: 'Book',
      textCancel: 'Cancel',
      onConfirm: () {
        if (customerNameController.text.isEmpty ||
            customerPhoneController.text.isEmpty) {
          Get.snackbar(
            'Error',
            'Please enter name and phone number',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        controller.bookSeat(
          ownerId: owner.ownerId,
          routeName: routeName,
          customerName: customerNameController.text,
          customerPhone: customerPhoneController.text,
        );

        customerNameController.clear();
        customerPhoneController.clear();

        Get.back();

        Get.snackbar(
          'Booking Created',
          'Your booking is pending until owner confirms payment',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ownerRoutes = controller.getRoutesByOwner(owner.ownerId);

    return Scaffold(
      appBar: AppBar(
        title: Text(owner.companyName),
        centerTitle: true,
      ),
      body: ownerRoutes.isEmpty
          ? const Center(
        child: Text(
          'No routes available for this owner',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: ownerRoutes.length,
        itemBuilder: (context, index) {
          final route = ownerRoutes[index];

          final vansNeeded = controller.calculateVans(
            route.passengers,
            owner.vanCapacity,
          );

          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route.routeName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 10),
                      Text('Departure: ${route.departureTime}'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.watch_later),
                      const SizedBox(width: 10),
                      Text('Return: ${route.returnTime}'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.people),
                      const SizedBox(width: 10),
                      Text('Passengers: ${route.passengers}'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.directions_bus),
                      const SizedBox(width: 10),
                      Text(
                        'Vans Needed: $vansNeeded',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Payment Info:\nJazzCash: ${owner.jazzCashNumber}\nBank: ${owner.bankAccount}\n\nAfter payment, owner will confirm your booking.',
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showBookingDialog(route.routeName);
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Book Seat'),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.snackbar(
                              'Live Tracking',
                              'Van arriving in 5 minutes',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          icon: const Icon(Icons.location_on),
                          label: const Text('Track'),
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
    );
  }
}