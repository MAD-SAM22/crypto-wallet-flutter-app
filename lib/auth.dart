import 'package:crypto_project/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'login_screen.dart';


class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xffff5f00),
                child: Icon(Icons.currency_bitcoin, size: 40, color: Colors.white),
              ),
              SizedBox(height: 16),

              // Welcome text
              Text(_isLogin ? "Welcome Back" : "Create Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(_isLogin ? "Sign in to your crypto wallet" : "Sign up to get started",
                  style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 32),


              // Show login or signup page content
              _isLogin ? LoginPage() : SignupPage(),




              // Sign In button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffff5f00),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {

                  },
                  child: Text(_isLogin? "Sign In": "Sign Up", style: TextStyle(fontSize: 18 , color: Colors.white)),
                ),
              ),
              SizedBox(height: 24),

              // Divider with OR
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 16),

              // Social login buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff3f4f6),
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.g_mobiledata, color: Colors.red),
                      label: Text("Google"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff3f4f6),
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.apple, color: Colors.black),
                      label: Text("Apple"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isLogin
                      ? "Don't have an account? "
                      : "Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isLogin = !_isLogin; // switch mode
                      });
                    },
                    child: Text(
                      _isLogin ? "Sign Up" : "Login",
                      style: TextStyle(
                        color: Color(0xffff5f00),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }


}

