import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transport_controller.dart';
import '../../models/route_model.dart';

class AddRouteScreen extends StatelessWidget {
  AddRouteScreen({super.key});

  final TransportController controller = Get.find<TransportController>();

  final TextEditingController routeNameController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController returnController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();

  void addRoute() {
    final owner = controller.currentOwner;

    if (owner == null) {
      Get.snackbar(
        'Error',
        'Please create owner profile first',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (routeNameController.text.isEmpty ||
        departureController.text.isEmpty ||
        returnController.text.isEmpty ||
        passengersController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all route fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final route = RouteModel(
      routeId: DateTime.now().millisecondsSinceEpoch.toString(),
      ownerId: owner.ownerId,
      routeName: routeNameController.text,
      departureTime: departureController.text,
      returnTime: returnController.text,
      passengers: int.tryParse(passengersController.text) ?? 0,
    );

    controller.addRoute(route);

    Get.back();

    Get.snackbar(
      'Route Added',
      'Your route has been added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Widget inputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Route'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            inputField(
              controller: routeNameController,
              label: 'Route Name',
            ),
            inputField(
              controller: departureController,
              label: 'Departure Time',
            ),
            inputField(
              controller: returnController,
              label: 'Return Time',
            ),
            inputField(
              controller: passengersController,
              label: 'Number of Passengers',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addRoute,
                child: const Text('Add Route'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}