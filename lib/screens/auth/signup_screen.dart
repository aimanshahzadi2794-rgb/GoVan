// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/auth_controller.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/custom_textfield.dart';
//
// class SignupScreen extends StatelessWidget {
//   SignupScreen({super.key});
//
//   final AuthController authController = Get.find<AuthController>();
//
//   final name = TextEditingController();
//   final email = TextEditingController();
//   final phone = TextEditingController();
//   final password = TextEditingController();
//   final confirmPassword = TextEditingController();
//
//   final business = TextEditingController();
//   final university = TextEditingController();
//   final ownerId = TextEditingController();
//
//   final formKey = GlobalKey<FormState>();
//   final isLoading = false.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     final String role = Get.arguments ?? 'customer';
//
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F7FA),
//
//       appBar: AppBar(
//         title: Text(role == 'owner' ? "Owner Signup" : "Customer Signup"),
//         elevation: 0,
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//
//         child: Form(
//           key: formKey,
//
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: role == 'owner'
//                         ? [Colors.blue, Colors.blueAccent]
//                         : [Colors.green, Colors.greenAccent],
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//
//                 child: Row(
//                   children: [
//                     Icon(
//                       role == 'owner' ? Icons.directions_bus : Icons.person,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//
//                     const SizedBox(width: 12),
//
//                     Text(
//                       role == 'owner'
//                           ? "Owner Registration"
//                           : "Customer Registration",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               _buildSection(
//                 "Personal Information",
//                 [
//                   CustomTextField(
//                     hint: "Full Name *",
//                     controller: name,
//                     icon: Icons.person,
//                     validator: (v) => v!.isEmpty ? "Required" : null,
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   CustomTextField(
//                     hint: "Email *",
//                     controller: email,
//                     icon: Icons.email,
//                     validator: (v) {
//                       if (v!.isEmpty) return "Required";
//                       if (!v.contains('@')) return "Invalid email";
//                       return null;
//                     },
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   CustomTextField(
//                     hint: "Phone *",
//                     controller: phone,
//                     icon: Icons.phone,
//                     validator: (v) => v!.isEmpty ? "Required" : null,
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   CustomTextField(
//                     hint: "Password *",
//                     controller: password,
//                     icon: Icons.lock,
//                     obscureText: true,
//                     validator: (v) => v!.length < 6 ? "Min 6 chars" : null,
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   CustomTextField(
//                     hint: "Confirm Password *",
//                     controller: confirmPassword,
//                     icon: Icons.lock,
//                     obscureText: true,
//                     validator: (v) {
//                       if (v != password.text) {
//                         return "Passwords don't match";
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 15),
//
//               _buildSection(
//                 role == 'owner'
//                     ? "Business Details"
//                     : "Education Details",
//                 role == 'owner'
//                     ? [
//                   CustomTextField(
//                     hint: "Business Name *",
//                     controller: business,
//                     icon: Icons.business,
//                     validator: (v) => v!.isEmpty ? "Required" : null,
//                   ),
//                 ]
//                     : [
//                   CustomTextField(
//                     hint: "University / Institute *",
//                     controller: university,
//                     icon: Icons.school,
//                     validator: (v) => v!.isEmpty ? "Required" : null,
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 30),
//
//               Obx(
//                     () => CustomButton(
//                   text: "Create Account",
//                   isLoading: isLoading.value,
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       isLoading.value = true;
//
//                       authController.signup(
//                         fullName: name.text,
//                         email: email.text,
//                         phone: phone.text,
//                         password: password.text,
//                         role: role,
//                         businessName: role == 'owner' ? business.text : null,
//                         university: role == 'customer' ? university.text : null,
//                         ownerId: role == 'customer' ? ownerId.text : null,
//                       );
//
//                       isLoading.value = false;
//
//                       if (role == 'owner') {
//                         Get.offAllNamed('/owner');
//                       } else {
//                         Get.offAllNamed('/customer');
//                       }
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection(String title, List<Widget> children) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(height: 15),
//
//           ...children,
//         ],
//       ),
//     );
//   }
// }















import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final business = TextEditingController();
  final university = TextEditingController();
  final ownerId = TextEditingController();

  final address = TextEditingController();
  final phone2 = TextEditingController();
  final jazzCash = TextEditingController();
  final bankAccount = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final role = Get.arguments ?? 'customer';

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        title: Text(role == 'owner' ? "Owner Signup" : "Customer Signup"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: role == 'owner'
                        ? [Colors.blue, Colors.blueAccent]
                        : [Colors.green, Colors.greenAccent],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(
                      role == 'owner' ? Icons.directions_bus : Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      role == 'owner'
                          ? "Owner Registration"
                          : "Customer Registration",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              _buildSection(
                "Personal Information",
                [
                  CustomTextField(
                    hint: "Full Name *",
                    controller: name,
                    icon: Icons.person,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Email *",
                    controller: email,
                    icon: Icons.email,
                    validator: (v) {
                      if (v!.isEmpty) return "Required";
                      if (!v.contains('@')) return "Invalid email";
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Phone *",
                    controller: phone,
                    icon: Icons.phone,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Password *",
                    controller: password,
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Required";
                      if (v.length < 6) return "Min 6 chars";
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Confirm Password *",
                    controller: confirmPassword,
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Required";
                      if (v != password.text) return "Passwords don't match";
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 15),

              _buildSection(
                role == 'owner'
                    ? "Business & Payment Details"
                    : "Education & Owner Details",
                role == 'owner'
                    ? [
                  CustomTextField(
                    hint: "Business Name *",
                    controller: business,
                    icon: Icons.business,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Business Address *",
                    controller: address,
                    icon: Icons.location_on,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Second Phone Number *",
                    controller: phone2,
                    icon: Icons.phone_android,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "JazzCash / Easypaisa Number *",
                    controller: jazzCash,
                    icon: Icons.account_balance_wallet,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Bank Account Details *",
                    controller: bankAccount,
                    icon: Icons.account_balance,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                ]
                    : [
                  CustomTextField(
                    hint: "University *",
                    controller: university,
                    icon: Icons.school,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 10),

                  CustomTextField(
                    hint: "Owner ID * (6 chars)",
                    controller: ownerId,
                    icon: Icons.key,
                    validator: (v) {
                      if (v!.isEmpty) return "Required";
                      if (v.length != 6) return "Must be 6 characters";
                      if (!authController.validateOwnerId(v)) {
                        return "Invalid Owner ID";
                      }
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Obx(
                    () => CustomButton(
                  text: "Create Account",
                  isLoading: isLoading.value,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      isLoading.value = true;

                      authController.signup(
                        fullName: name.text.trim(),
                        email: email.text.trim(),
                        phone: phone.text.trim(),
                        password: password.text.trim(),
                        role: role,
                        businessName:
                        role == 'owner' ? business.text.trim() : null,
                        university:
                        role == 'customer' ? university.text.trim() : null,
                        ownerId:
                        role == 'customer' ? ownerId.text.trim() : null,
                        address:
                        role == 'owner' ? address.text.trim() : null,
                        phone2:
                        role == 'owner' ? phone2.text.trim() : null,
                        jazzCashNumber:
                        role == 'owner' ? jazzCash.text.trim() : null,
                        bankAccount:
                        role == 'owner' ? bankAccount.text.trim() : null,

                      );

                      isLoading.value = false;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }
}