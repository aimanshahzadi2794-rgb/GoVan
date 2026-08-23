// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter/material.dart';
// import '../models/user_model.dart';
//
// class AuthController extends GetxController {
//   final box = GetStorage();
//
//   var currentUser = Rxn<UserModel>();
//   var isLoggedIn = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     checkLoginStatus();
//   }
//
//   void checkLoginStatus() {
//     String? userId = box.read('currentUserId');
//     bool? rememberMe = box.read('rememberMe') ?? false;
//
//     if (userId != null && rememberMe) {
//       List<dynamic> users = box.read('users') ?? [];
//       var userData = users.firstWhere(
//             (u) => u['id'] == userId,
//         orElse: () => null,
//       );
//       if (userData != null) {
//         currentUser.value = UserModel.fromMap(userData);
//         isLoggedIn.value = true;
//       }
//     } else {
//       // Clear if remember me was false
//       box.remove('currentUserId');
//       isLoggedIn.value = false;
//     }
//   }
//
//   // Generate random Owner ID (6 chars: letters + numbers)
//   String generateOwnerId() {
//     const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     String result = '';
//     for (int i = 0; i < 6; i++) {
//       final random = DateTime.now().millisecondsSinceEpoch + i;
//       final index = random.abs() % chars.length;
//       result += chars[index];
//     }
//     return result;
//   }
//
//   // Signup
//   void signup({
//     required String fullName,
//     required String email,
//     required String phone,
//     required String password,
//     required String role,
//     String? businessName,
//     String? university,
//     String? ownerId,
//   }) {
//     List<dynamic> users = box.read('users') ?? [];
//
//     // Check if email already exists
//     bool emailExists = users.any((u) => u['email'] == email);
//     if (emailExists) {
//       Get.snackbar('Error', 'Email already registered!');
//       return;
//     }
//
//     String generatedOwnerId = '';
//     if (role == 'owner') {
//       generatedOwnerId = generateOwnerId();
//     }
//
//     // Create new user
//     String userId = DateTime.now().millisecondsSinceEpoch.toString();
//     UserModel newUser = UserModel(
//       id: userId,
//       fullName: fullName,
//       email: email,
//       phone: phone,
//       password: password,
//       role: role,
//       businessName: businessName,
//       university: university,
//       ownerId: ownerId,
//       generatedOwnerId: generatedOwnerId,
//     );
//
//     users.add(newUser.toMap());
//     box.write('users', users);
//
//     // Navigate based on role
//     if (role == 'owner') {
//       // Show Owner ID dialog then navigate to login
//       Get.dialog(
//         AlertDialog(
//           title: const Text("🎉 Owner Account Created!"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Your Owner ID is:"),
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   generatedOwnerId,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Share this ID with customers so they can register under your business!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 12),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.back(); // Close dialog
//                 Get.offAllNamed('/login'); // Navigate to login
//               },
//               child: const Text("Go to Login"),
//             ),
//           ],
//         ),
//         barrierDismissible: false,
//       );
//     } else {
//       // Customer signup - direct navigation
//       Get.snackbar(
//         'Success',
//         'Account created successfully!',
//         duration: const Duration(seconds: 2),
//       );
//       Get.offAllNamed('/login');
//     }
//   }
//
//   // Login - UPDATED with remember me
//   bool login(String email, String password, bool rememberMe) {
//     List<dynamic> users = box.read('users') ?? [];
//
//     var userData = users.firstWhere(
//           (u) => u['email'] == email && u['password'] == password,
//       orElse: () => null,
//     );
//
//     if (userData == null) {
//       Get.snackbar(
//         'Error',
//         'Invalid email or password!',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     }
//
//     currentUser.value = UserModel.fromMap(userData);
//     box.write('currentUserId', currentUser.value!.id);
//     box.write('rememberMe', rememberMe); // Save remember me preference
//     isLoggedIn.value = true;
//
//     Get.snackbar(
//       'Success',
//       'Welcome back, ${currentUser.value!.fullName}!',
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );
//     return true;
//   }
//
//   // Logout
//   void logout() {
//     box.remove('currentUserId');
//     // Don't remove rememberMe - keep preference
//     currentUser.value = null;
//     isLoggedIn.value = false;
//     Get.offAllNamed('/role');
//   }
//
//   // Get all customers for an owner
//   List<UserModel> getMyCustomers() {
//     if (currentUser.value?.role != 'owner') return [];
//
//     List<dynamic> users = box.read('users') ?? [];
//     List<UserModel> customers = [];
//
//     for (var user in users) {
//       UserModel u = UserModel.fromMap(user);
//       if (u.role == 'customer' && u.ownerId == currentUser.value?.generatedOwnerId) {
//         customers.add(u);
//       }
//     }
//     return customers;
//   }
//
//   // Validate Owner ID (for customer signup)
//   bool validateOwnerId(String ownerId) {
//     List<dynamic> users = box.read('users') ?? [];
//     return users.any((u) => u['role'] == 'owner' && u['generatedOwnerId'] == ownerId);
//   }
//
//   // Get owner by ID
//   UserModel? getOwnerById(String ownerId) {
//     List<dynamic> users = box.read('users') ?? [];
//     var userData = users.firstWhere(
//           (u) => u['role'] == 'owner' && u['generatedOwnerId'] == ownerId,
//       orElse: () => null,
//     );
//     if (userData != null) {
//       return UserModel.fromMap(userData);
//     }
//     return null;
//   }
// }


















import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class AuthController extends GetxController {
  final box = GetStorage();

  final currentUser = Rxn<UserModel>();
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();

    final savedUser = box.read('currentUser');

    if (savedUser != null) {
      currentUser.value = UserModel.fromJson(
        Map<String, dynamic>.from(savedUser),
      );
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  bool login(String email, String password, bool rememberMe) {
    try {
      final List storedUsers = box.read('users') ?? [];

      final matchedUser = storedUsers.firstWhereOrNull((user) {
        final mapUser = Map<String, dynamic>.from(user);

        return mapUser['email'] == email.trim() &&
            mapUser['password'] == password.trim();
      });

      if (matchedUser == null) {
        Get.snackbar(
          'Login Failed',
          'No account found with this email and password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final userMap = Map<String, dynamic>.from(matchedUser);

      currentUser.value = UserModel.fromJson(userMap);
      isLoggedIn.value = true;

      box.write('rememberMe', rememberMe);

      if (rememberMe) {
        box.write('currentUser', userMap);
      } else {
        box.remove('currentUser');
      }

      Get.snackbar(
        'Login Success',
        'Welcome ${currentUser.value?.fullName ?? ''}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login error: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  void signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
    String? businessName,
    String? university,
    String? ownerId,
    String? address,
    String? phone2,
    String? jazzCashNumber,
    String? bankAccount,
  }) {
    try {
      final List storedUsers = box.read('users') ?? [];

      final existingUser = storedUsers.firstWhereOrNull((user) {
        final mapUser = Map<String, dynamic>.from(user);
        return mapUser['email'] == email.trim();
      });

      if (existingUser != null) {
        Get.snackbar(
          'Signup Failed',
          'An account already exists with this email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final String generatedOwnerId =
      role == 'owner' ? _generateOwnerId() : '';

      final user = UserModel(
        fullName: fullName.trim(),
        email: email.trim(),
        phone: phone.trim(),
        password: password.trim(),
        role: role,
        businessName: role == 'owner' ? businessName : null,
        university: role == 'customer' ? university : null,
        ownerId: role == 'customer' ? ownerId : null,
        generatedOwnerId: role == 'owner' ? generatedOwnerId : null,
        address: role == 'owner' ? address : null,
        phone2: role == 'owner' ? phone2 : null,
        jazzCashNumber: role == 'owner' ? jazzCashNumber : null,
        bankAccount: role == 'owner' ? bankAccount : null,
      );

      storedUsers.add(user.toJson());
      box.write('users', storedUsers);

      currentUser.value = user;
      isLoggedIn.value = true;

      box.write('currentUser', user.toJson());

      Get.snackbar(
        'Signup Success',
        role == 'owner'
            ? 'Owner account created. Your Owner ID is $generatedOwnerId'
            : 'Customer account created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      if (role == 'owner') {
        Get.offAllNamed('/owner');
      } else {
        Get.offAllNamed('/customer');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Signup error: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool validateOwnerId(String ownerId) {
    final List storedUsers = box.read('users') ?? [];

    return storedUsers.any((user) {
      final mapUser = Map<String, dynamic>.from(user);

      return mapUser['role'] == 'owner' &&
          mapUser['generatedOwnerId'] == ownerId.trim();
    });
  }

  List<UserModel> getAllOwners() {
    final List storedUsers = box.read('users') ?? [];

    return storedUsers
        .map((user) => UserModel.fromJson(Map<String, dynamic>.from(user)))
        .where((user) => user.role == 'owner')
        .toList();
  }

  List<UserModel> getMyCustomers() {
    final owner = currentUser.value;

    if (owner == null || owner.role != 'owner') {
      return [];
    }

    final ownerGeneratedId = owner.generatedOwnerId;

    final List storedUsers = box.read('users') ?? [];

    return storedUsers
        .map((user) => UserModel.fromJson(Map<String, dynamic>.from(user)))
        .where((user) =>
    user.role == 'customer' && user.ownerId == ownerGeneratedId)
        .toList();
  }

  void logout() {
    currentUser.value = null;
    isLoggedIn.value = false;

    box.remove('currentUser');
    Get.offAllNamed('/role');
  }

  String _generateOwnerId() {
    final millis = DateTime.now().millisecondsSinceEpoch.toString();
    return millis.substring(millis.length - 6);
  }
}