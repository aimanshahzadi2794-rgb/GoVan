import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.directions_bus,
              size: 100,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              "Smart Transport\nCoordination System",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            CustomButton(
              text: "Login",
              onPressed: () {
                Get.toNamed('/login');
              },
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: "Sign Up",
              onPressed: () {
                Get.toNamed('/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}