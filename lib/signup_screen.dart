import 'package:flutter/material.dart';
import 'input_field.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Full Name",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InputField(
          hint: "Enter your full name",
          icon: Icons.person,
        ),
        const SizedBox(height: 16),

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

        const Text(
          "Phone Number",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InputField(
          hint: "Enter your phone number",
          icon: Icons.phone,
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
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
