import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  late AuthController authController;
  late String role;

  bool hidePassword = true;
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
    role = Get.arguments ?? 'customer';
    rememberMe = authController.box.read('rememberMe') ?? false;
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const BouncingScrollPhysics(),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: role == 'owner' ? Colors.blue.shade50 : Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            role == 'owner' ? Icons.business : Icons.person,
                            size: 50,
                            color: role == 'owner' ? Colors.blue : Colors.green,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          role == 'owner' ? "Owner Login" : "Customer Login",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),

                        Text(
                          "Login to your account",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Email Field
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email, size: 20),
                            hintText: "Email",
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                          validator: (v) {
                            if (v!.isEmpty) return "Email required";
                            if (!v.contains('@')) return "Invalid email";
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // Password Field
                        TextFormField(
                          controller: password,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, size: 20),
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword ? Icons.visibility_off : Icons.visibility,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                          validator: (v) {
                            if (v!.isEmpty) return "Password required";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Remember Me & Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: rememberMe,
                                    onChanged: (val) {
                                      setState(() {
                                        rememberMe = val ?? false;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text("Remember Me", style: TextStyle(fontSize: 13)),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Get.snackbar(
                                  "Forgot Password?",
                                  "Contact support to reset password",
                                  backgroundColor: Colors.orange,
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 2),
                                );
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text("Forgot Password?", style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                await Future.delayed(const Duration(milliseconds: 500));

                                bool success = authController.login(
                                  email.text,
                                  password.text,
                                  rememberMe,
                                );

                                setState(() {
                                  isLoading = false;
                                });

                                if (success) {
                                  if (authController.currentUser.value?.role == 'owner') {
                                    Get.offAllNamed('/owner');
                                  } else {
                                    Get.offAllNamed('/customer');
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: role == 'owner' ? Colors.blue : Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                                : const Text(
                              "Login",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/signup', arguments: role);
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text("Sign Up", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}