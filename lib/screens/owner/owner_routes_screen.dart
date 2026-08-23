import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transport_controller.dart';

class OwnerRoutesScreen extends StatelessWidget {
  OwnerRoutesScreen({super.key});

  final TransportController controller = Get.find<TransportController>();

  @override
  Widget build(BuildContext context) {
    final owner = controller.currentOwner;

    if (owner == null) {
      return const Scaffold(
        body: Center(
          child: Text('No owner profile found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Routes'),
        centerTitle: true,
      ),
      body: Obx(() {
        final ownerRoutes = controller.getRoutesByOwner(owner.ownerId);

        if (ownerRoutes.isEmpty) {
          return const Center(
            child: Text(
              'No routes added yet',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
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

                    const SizedBox(height: 10),

                    Text('Departure: ${route.departureTime}'),
                    Text('Return: ${route.returnTime}'),
                    Text('Passengers: ${route.passengers}'),

                    const SizedBox(height: 10),

                    Text(
                      'Vans Needed: $vansNeeded',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
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