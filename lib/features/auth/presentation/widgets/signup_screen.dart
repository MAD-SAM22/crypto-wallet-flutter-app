import 'package:flutter/material.dart';
import '../../../../components/input_field.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  const SignupPage({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
  });

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
          controller: nameController,
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
          controller: emailController,
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
          controller: phoneController,
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
        const SizedBox(height: 24),
      ],
    );
  }
}
