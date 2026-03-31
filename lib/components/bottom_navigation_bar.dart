import 'package:crypto_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int _selectedIndex = 0; // Keeping track of the active tab
  final List<Widget> _screens = [
    HomeScreen(),
    const Center(child: Text("Markets Screen")),
    const Center(child: Text("Trades Screen")),
    const Center(child: Text("Activity Screen")),
    const Center(child: Text("Wallets Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _screens[_selectedIndex],

          // 2. Custom Floating Bottom Navbar
          Positioned(
            bottom: 30, // Distance from the absolute bottom of the screen
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9, // 90% width
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                // Matching the dark charcoal background of your reference
                color: const Color(0xFF1B1D1F),
                borderRadius: BorderRadius.circular(30), // Smooth rounded edges
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(0, 8), // Position the shadow below
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navItem(Icons.home_outlined, "Home", 0),
                  _navItem(Icons.bar_chart_outlined, "Markets", 1),
                  _navItem(Icons.swap_horiz_outlined, "Trades", 2),
                  _navItem(Icons.history, "Activity", 3),
                  _navItem(Icons.account_balance_wallet_outlined, "Wallets", 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Individual Nav Item Component
  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    // Our active theme color vs the reference's gray
    final activeColor = const Color(0xffff5f00);
    final unselectedColor = Colors.grey[500];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon with dynamic color and a subtle glow when active
          Icon(
            icon,
            color: isSelected ? activeColor : unselectedColor,
            size: 26,
          ),
          const SizedBox(height: 6),
          // Label text
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              // Keeping unselected labels gray to match reference contrast
              color: isSelected ? activeColor : unselectedColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}