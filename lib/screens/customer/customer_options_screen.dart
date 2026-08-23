// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'owners_list_screen.dart';
//
// class CustomerOptionsScreen extends StatelessWidget {
//   const CustomerOptionsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F7FA),
//       appBar: AppBar(
//         title: const Text("Customer Options"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.person,
//               size: 90,
//               color: Colors.green,
//             ),
//
//             const SizedBox(height: 20),
//
//             const Text(
//               "Continue as Customer",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             const Text(
//               "Choose what you want to do",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//
//             const SizedBox(height: 35),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Get.to(() => OwnersListScreen());
//                 },
//                 icon: const Icon(Icons.info),
//                 label: const Text("Owner Details"),
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Get.toNamed('/login', arguments: 'customer');
//                 },
//                 icon: const Icon(Icons.login),
//                 label: const Text("Login"),
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton.icon(
//                 onPressed: () {
//                   Get.toNamed('/signup', arguments: 'customer');
//                 },
//                 icon: const Icon(Icons.person_add),
//                 label: const Text("Sign Up"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOptionsScreen extends StatelessWidget {
  const CustomerOptionsScreen({super.key});

  void showOwnerDetails() {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.82,
        ),
        decoration: const BoxDecoration(
          color: Color(0xffF4FBFC),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),

            Container(
              width: 46,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "Available Owners",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff12323A),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Owner contact and business location",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                children: [
                  _ownerCard(
                    companyName: "SmartRoute Transport",
                    ownerName: "Ali Khan",
                    phone: "0300-1234567",
                    location: "Johar Town, Lahore",
                  ),
                  _ownerCard(
                    companyName: "Safe Van Services",
                    ownerName: "Ahmed Raza",
                    phone: "0321-1234567",
                    location: "Model Town, Lahore",
                  ),
                  _ownerCard(
                    companyName: "City Ride Transport",
                    ownerName: "Usman Malik",
                    phone: "0345-1234567",
                    location: "Thokar Niaz Baig, Lahore",
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff00AFC8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  static Widget _ownerCard({
    required String companyName,
    required String ownerName,
    required String phone,
    required String location,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xffD8F3F7)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff00AFC8).withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            companyName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff12323A),
            ),
          ),

          const SizedBox(height: 12),

          _detailRow(
            title: "Owner",
            value: ownerName,
            icon: Icons.person,
          ),

          const SizedBox(height: 10),

          _detailRow(
            title: "Phone",
            value: phone,
            icon: Icons.phone,
          ),

          const SizedBox(height: 10),

          _detailRow(
            title: "Business Location",
            value: location,
            icon: Icons.location_on,
          ),
        ],
      ),
    );
  }

  static Widget _detailRow({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xff00AFC8).withOpacity(0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: const Color(0xff00AFC8),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff12323A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _optionButton({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool filled,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: filled ? const Color(0xff00AFC8) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: filled ? const Color(0xff00AFC8) : const Color(0xffD8F3F7),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff00AFC8).withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: filled ? Colors.white : const Color(0xff12323A),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: filled
                          ? Colors.white.withOpacity(0.90)
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: filled
                    ? Colors.white.withOpacity(0.20)
                    : const Color(0xff00AFC8).withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: filled ? Colors.white : const Color(0xff00AFC8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff00AFC8).withOpacity(0.10),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Color(0xff12323A),
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    "Customer",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff12323A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const Text(
                "Customer Access",
                style: TextStyle(
                  fontSize: 31,
                  height: 1.15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff12323A),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "View owner information or continue with your customer account.",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 26),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff04BFD8),
                      Color(0xff00AFC8),
                      Color(0xff05D3DE),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff00AFC8).withOpacity(0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/app_logo.jpeg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.directions_bus,
                              color: Color(0xff00AFC8),
                              size: 35,
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "GoVan Customer",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      "Choose an option below to view owner details, login, or create your account.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: Colors.white.withOpacity(0.90),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              _optionButton(
                title: "Owner Details",
                subtitle: "View owner phone number and business location",
                filled: true,
                onTap: showOwnerDetails,
              ),

              _optionButton(
                title: "Login",
                subtitle: "Already registered? Continue to your dashboard",
                filled: false,
                onTap: () {
                  Get.toNamed('/login', arguments: 'customer');
                },
              ),

              _optionButton(
                title: "Sign Up",
                subtitle: "Create a new customer account",
                filled: false,
                onTap: () {
                  Get.toNamed('/signup', arguments: 'customer');
                },
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  "GoVan • Smart Transport, Safe Journey",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}