import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transport_controller.dart';
import '../../models/owner_model.dart';
import 'owner_dashboard.dart';

class OwnerProfileScreen extends StatelessWidget {
  OwnerProfileScreen({super.key});

  final TransportController controller = Get.find<TransportController>();

  final TextEditingController companyController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phone1Controller = TextEditingController();
  final TextEditingController phone2Controller = TextEditingController();
  final TextEditingController jazzCashController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController vanCapacityController = TextEditingController();

  Widget inputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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

  void saveOwnerProfile() {
    if (companyController.text.isEmpty ||
        ownerNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        phone1Controller.text.isEmpty ||
        phone2Controller.text.isEmpty ||
        jazzCashController.text.isEmpty ||
        bankController.text.isEmpty ||
        vanCapacityController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all owner details',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final owner = OwnerModel(
      ownerId: DateTime.now().millisecondsSinceEpoch.toString(),
      companyName: companyController.text,
      ownerName: ownerNameController.text,
      address: addressController.text,
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      jazzCashNumber: jazzCashController.text,
      bankAccount: bankController.text,
      vanCapacity: int.tryParse(vanCapacityController.text) ?? 10,
    );

    controller.registerOwner(owner);

    Get.off(() => OwnerDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            inputField(
              controller: companyController,
              label: 'Company / Transport Name',
            ),
            inputField(
              controller: ownerNameController,
              label: 'Owner Name',
            ),
            inputField(
              controller: addressController,
              label: 'Address',
            ),
            inputField(
              controller: phone1Controller,
              label: 'Phone Number 1',
              keyboardType: TextInputType.phone,
            ),
            inputField(
              controller: phone2Controller,
              label: 'Phone Number 2',
              keyboardType: TextInputType.phone,
            ),
            inputField(
              controller: jazzCashController,
              label: 'JazzCash / Easypaisa Number',
              keyboardType: TextInputType.phone,
            ),
            inputField(
              controller: bankController,
              label: 'Bank Account Details',
            ),
            inputField(
              controller: vanCapacityController,
              label: 'Van Capacity',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveOwnerProfile,
                child: const Text('Save Owner Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}