import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State variables for toggles and selections
  bool _notificationsEnabled = true;
  bool _faceIdEnabled = false;
  String _selectedCurrency = 'USD (\$)';
  String _selectedTheme = 'Light Mode';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // --- ACCOUNT SECTION ---
          _buildSectionHeader('Account'),
          _buildSettingTile(
            icon: Icons.person_outline,
            title: 'Profile Details',
            onTap: () {},
          ),
          _buildSettingTile(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Payment Methods',
            onTap: () {},
          ),

          const SizedBox(height: 25),

          // --- PREFERENCES SECTION ---
          _buildSectionHeader('Preferences'),
          _buildSettingTile(
            icon: Icons.payments_outlined,
            title: 'Default Currency',
            trailingText: _selectedCurrency,
            onTap: () => _showCurrencyPicker(context),
          ),
          _buildSettingTile(
            icon: Icons.dark_mode_outlined,
            title: 'Appearance',
            trailingText: _selectedTheme,
            onTap: () => _showAppearancePicker(context),
          ),
          _buildSettingTile(
            icon: Icons.language_rounded,
            title: 'Language',
            trailingText: 'English',
            onTap: () {},
          ),

          const SizedBox(height: 25),

          // --- SECURITY SECTION ---
          _buildSectionHeader('Security'),
          _buildToggleTile(
            icon: Icons.notifications_none_rounded,
            title: 'Push Notifications',
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          _buildToggleTile(
            icon: Icons.face_unlock_rounded,
            title: 'Face ID / Biometrics',
            value: _faceIdEnabled,
            onChanged: (val) => setState(() => _faceIdEnabled = val),
          ),
          _buildSettingTile(
            icon: Icons.lock_outline_rounded,
            title: 'Change Password',
            onTap: () {},
          ),

          const SizedBox(height: 25),

          // --- GENERAL SECTION ---
          _buildSectionHeader('General'),
          _buildSettingTile(
            icon: Icons.help_outline_rounded,
            title: 'Help & Support',
            onTap: () {},
          ),
          _buildSettingTile(
            icon: Icons.info_outline_rounded,
            title: 'About App',
            onTap: () {},
          ),

          const SizedBox(height: 40),

          // --- LOGOUT BUTTON ---
          TextButton(
            onPressed: () {
              // Handle logout logic
            },
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded),
                SizedBox(width: 8),
                Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),

          // Space to ensure floating navbar doesn't cover content
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  // --- UI HELPER COMPONENTS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.indigo.shade800, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.indigo.shade800, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Switch.adaptive(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }

  // --- SELECTION PICKERS ---

  void _showCurrencyPicker(BuildContext context) {
    final currencies = [
      {'code': 'USD (\$)', 'name': 'United States Dollar'},
      {'code': 'EUR (€)', 'name': 'Euro'},
      {'code': 'GBP (£)', 'name': 'British Pound'},
      {'code': 'JPY (¥)', 'name': 'Japanese Yen'},
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Currency',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ...currencies.map((c) => ListTile(
                title: Text(c['code']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(c['name']!),
                trailing: _selectedCurrency == c['code']
                    ? const Icon(Icons.check_circle, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedCurrency = c['code']!);
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        );
      },
    );
  }

  void _showAppearancePicker(BuildContext context) {
    final themes = [
      {'label': 'Light Mode', 'icon': Icons.wb_sunny_outlined},
      {'label': 'Dark Mode', 'icon': Icons.nightlight_round},
      {'label': 'System Default', 'icon': Icons.settings_brightness_outlined},
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Appearance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ...themes.map((t) => ListTile(
                leading: Icon(t['icon'] as IconData),
                title: Text(t['label'] as String),
                trailing: _selectedTheme == t['label']
                    ? const Icon(Icons.radio_button_checked, color: AppColors.primary)
                    : const Icon(Icons.radio_button_off, color: Colors.grey),
                onTap: () {
                  setState(() => _selectedTheme = t['label'] as String);
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        );
      },
    );
  }
}