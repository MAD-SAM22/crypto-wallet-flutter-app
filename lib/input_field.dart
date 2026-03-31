import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  // final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;

  const InputField({
    Key? key,
    // required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        // labelText: widget.label,
        hintText: widget.hint,
        border: OutlineInputBorder(),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
    );
  }
}