import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get.dart';

Logincontroller loginController = Get.put(Logincontroller());
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                              child: Icon(
                                loginController.isPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onTap: () {
                                loginController.togglePassword();
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      GestureDetector(
                        onTap: () {
                          bool success = loginController.login(
                            usernameController.text,
                            passwordController.text,
                          );

                          if (success) {
                            Get.toNamed("/homescreen");
                          } else {
                            Get.snackbar(
                              "Login Failed",
                              "Invalid username or password",
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
