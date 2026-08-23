import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';

class OwnersListScreen extends StatelessWidget {
  OwnersListScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final owners = authController.getAllOwners();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Owners'),
        centerTitle: true,
      ),
      body: owners.isEmpty
          ? const Center(
        child: Text(
          'No registered owners yet',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: owners.length,
        itemBuilder: (context, index) {
          final owner = owners[index];

          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    owner.businessName ?? 'Transport Company',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Owner: ${owner.fullName}'),
                  Text('Phone: ${owner.phone}'),
                  Text('Business Location: ${owner.address ?? 'N/A'}'),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(
                              () => CustomerOwnerDetailsScreen(owner: owner),
                        );
                      },
                      icon: const Icon(Icons.info),
                      label: const Text('View Full Details'),
                    ),
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

class CustomerOwnerDetailsScreen extends StatelessWidget {
  final UserModel owner;

  const CustomerOwnerDetailsScreen({
    super.key,
    required this.owner,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoCard(
              title: owner.businessName ?? 'Transport Company',
              icon: Icons.business,
              children: [
                _row("Owner Name", owner.fullName),
                _row("Email", owner.email),
                _row("Phone 1", owner.phone),
                _row("Phone 2", owner.phone2 ?? 'N/A'),
                _row("Business Location", owner.address ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 16),
            _infoCard(
              title: "Owner Contact & Payment Details",
              icon: Icons.payment,
              children: [
                _row("Owner Phone 1", owner.phone),
                _row("Owner Phone 2", owner.phone2 ?? 'N/A'),
                _row("JazzCash / Easypaisa", owner.jazzCashNumber ?? 'N/A'),
                _row("Bank Account", owner.bankAccount ?? 'N/A'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 135,
            child: Text(
              "$title:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}