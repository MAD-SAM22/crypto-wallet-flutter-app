import 'package:flutter/material.dart';
import 'portfolio_value_card.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
      decoration: const BoxDecoration(
        color: Color(0xffff5f00),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.indigo),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back,",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text("Nivas Kanniah",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Spacer(),
              Icon(Icons.notifications_none, color: Colors.white),
              SizedBox(width: 15),
              Icon(Icons.menu, color: Colors.white),
            ],
          ),
          SizedBox(height: 30),
          PortfolioCard(),
        ],
      ),
    );
  }
}
