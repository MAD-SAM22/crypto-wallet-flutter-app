import 'package:crypto_project/features/history/history_screen.dart';
import 'package:crypto_project/features/markets/presentation/screens/markets_screen.dart';
import 'package:crypto_project/features/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'home/presentation/screens/home_screen.dart';
import 'trades/presentation/screens/trade_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  void setIndex(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    super.initState();

    _screens = [
      const HomeScreen(),
      const MarketsScreen(),
      const TradeScreen(),
      const HistoryScreen(),
      WalletScreen(onShowHistory: () {
        setState(() => _selectedIndex = 3);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. The Dynamic Page Content
          _screens[_selectedIndex],

          // 2. The Floating Navbar
          Positioned(
            bottom: 25, // Distance from screen bottom
            child: _buildFloatingNavbar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavbar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1D1F),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(Icons.home_filled, "Home", 0),
          _navItem(Icons.bar_chart_rounded, "Markets", 1),
          _navItem(Icons.swap_horiz_rounded, "Trades", 2),
          _navItem(Icons.history_rounded, "Activity", 3),
          _navItem(Icons.account_balance_wallet_rounded, "Wallets", 4),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    const activeColor = AppColors.primary;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? activeColor : Colors.grey[500],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? activeColor : Colors.grey[500],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
