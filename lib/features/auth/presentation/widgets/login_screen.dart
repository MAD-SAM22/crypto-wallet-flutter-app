import 'package:flutter/material.dart';
import '../../../../components/input_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginPage({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InputField(
          hint: "name@example.com",
          icon: Icons.email,
          controller: emailController,
        ),
        const SizedBox(height: 16),
        const Text(
          "Password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InputField(
          hint: "Enter your password",
          icon: Icons.lock,
          isPassword: true,
          controller: passwordController,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text("Forgot Password?",
                style: TextStyle(color: Color(0xffff5f00))),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
