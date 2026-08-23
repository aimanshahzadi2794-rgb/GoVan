import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/auth_controller.dart';
import 'controllers/transport_controller.dart';

import 'screens/auth/splash_screen.dart';
import 'screens/auth/role_selection_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/owner/owner_dashboard.dart';
import 'screens/customer/customer_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.put(AuthController(), permanent: true);
  Get.put(TransportController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Transport Coordination System',
      initialRoute: '/',

      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/role', page: () => const RoleSelectionScreen()),

        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),

        GetPage(
          name: '/signup',
          page: () => SignupScreen(),
        ),

        GetPage(name: '/owner', page: () => OwnerDashboard()),
        GetPage(name: '/customer', page: () => CustomerDashboard()),
      ],
    );
  }
}