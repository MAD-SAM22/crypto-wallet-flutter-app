import 'package:flutter/material.dart';
import '../../../../components/input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
        const InputField(
          hint: "name@example.com",
          icon: Icons.email,
        ),
        const SizedBox(height: 16),
        const Text(
          "Password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        const InputField(
          hint: "Enter your password",
          icon: Icons.lock,
          isPassword: true,
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
