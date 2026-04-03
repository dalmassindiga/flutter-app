import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Logincontroller loginController = Get.put(Logincontroller());

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> login() async {
    String email = usernameController.text.trim();
    String password = passwordController.text.trim();

    // Validation
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      Get.snackbar("Error", "Enter a valid email address");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse(
          "http://localhost/flutter_application_1/login.php?email=$email&password=$password",
        ),
      );

      final data = jsonDecode(response.body);

      if (data['success'] == 1) {
        Get.snackbar("Success", "Login successful!");
        // Save user data
        final user = data['data'];
        Get.offNamed("/homescreen", arguments: user);
      } else {
        Get.snackbar("Login Failed", "Invalid email or password");
      }
    } catch (e) {
      Get.snackbar("Error", "Could not connect to server");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/garage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/BM logo.jpg',
                        height: 100,
                        width: 100,
                      ),
                      const Text(
                        "WrenchWise",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      TextField(
                        controller: usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Use email or phone number",
                          hintStyle: TextStyle(color: Colors.white54),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter password",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Obx(
                        () => TextField(
                          obscureText: loginController.isPasswordVisible.value,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "PIN or password",
                            hintStyle: TextStyle(color: Colors.white54),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                loginController.togglePassword();
                              },
                              child: Icon(
                                loginController.isPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      GestureDetector(
                        onTap: _isLoading ? null : login,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/signup");
                            },
                            child: Text(
                              "Signup",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Reset Password",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
