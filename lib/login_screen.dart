import 'package:flutter/material.dart';
import 'input_field.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email field
        const Text(
          "Email Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InputField(
          hint: "name@example.com",
          icon: Icons.email,
        ),
        const SizedBox(height: 16),

        // Password field
        const Text(
          "Password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InputField(
          hint: "Enter your password",
          icon: Icons.lock,
          isPassword: true,
        ),

        const SizedBox(height: 8),

        // Forgot password link
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
