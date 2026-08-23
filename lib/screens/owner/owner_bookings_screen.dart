import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/transport_controller.dart';

class OwnerBookingsScreen extends StatelessWidget {
  OwnerBookingsScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final TransportController transportController = Get.find<TransportController>();

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser.value;

    if (user == null || user.role != 'owner') {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Customer Bookings'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'No owner logged in',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final ownerId = user.generatedOwnerId ?? user.ownerId ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Bookings'),
        centerTitle: true,
      ),
      body: Obx(() {
        final ownerBookings = transportController.bookings
            .where((booking) => booking.ownerId == ownerId)
            .toList();

        if (ownerBookings.isEmpty) {
          return const Center(
            child: Text(
              'No bookings yet',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: ownerBookings.length,
          itemBuilder: (context, index) {
            final booking = ownerBookings[index];

            return Card(
              margin: const EdgeInsets.all(12),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.routeName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text('Customer: ${booking.customerName}'),
                    Text('Phone: ${booking.customerPhone}'),

                    const SizedBox(height: 10),

                    Text(
                      booking.paymentConfirmed
                          ? 'Payment Status: Confirmed'
                          : 'Payment Status: Pending',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: booking.paymentConfirmed
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),

                    const SizedBox(height: 15),

                    if (!booking.paymentConfirmed)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            transportController.confirmPayment(
                              booking.bookingId,
                            );

                            Get.snackbar(
                              'Payment Confirmed',
                              'Customer payment has been confirmed',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
                          icon: const Icon(Icons.verified),
                          label: const Text('Confirm Payment'),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}