import 'package:flutter/material.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../main_navigation.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key, this.onShowHistory});
  final VoidCallback? onShowHistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   // leading: const Icon(Icons.arrow_back, color: Colors.black87),
      //   title: const Text(
      //     'Balance Detail',
      //     style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   actions: const [
      //     Icon(Icons.more_vert, color: Colors.black87),
      //     SizedBox(width: 16),
      //   ],
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 75),

            // User Greeting Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Sam,',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Welcome from ur Wallet!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.orange.shade700,
                  child: const Icon(Icons.person, color: Colors.indigo, size: 35),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Credit Card Widget
            Container(
              width: double.infinity,
              child: const CreditCardUi(
              cardHolderFullName: 'Osama Hosam Abdellatif',
              cardNumber: '9876322111110000',
              validThru: '12/28',
              topLeftColor: Colors.orange, // Matches the top left of your image
              bottomRightColor: Colors.deepOrange, // Adds that subtle gradient shift
              cardType: CardType.debit, // In many versions, this triggers the default logo
              cardProviderLogoPosition: CardProviderLogoPosition.right,
              placeNfcIconAtTheEnd: true, //
              doesSupportNfc: true,
              showBalance: false, // We are showing the balance below the card per your UI
              enableFlipping: true,
              cvvNumber: '123',
            ),
            ),


            const SizedBox(height: 30),

            // Balance Section
            const Text('Balance', style: TextStyle(color: Colors.grey)),
            const Text(
              '\$50,530.00',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Upcoming Payments Section
            const Text(
              'Upcoming Payment',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 15),

            _buildPaymentTile(
              icon: Icons.pause, // Mocking the PayPal logo style
              title: 'Paypal',
              subtitle: 'X Subscription',
              amount: '\$100.00',
              iconColor: Colors.blue.shade900,
            ),
            _buildPaymentTile(
              icon: Icons.credit_card,
              title: 'Razorpay',
              subtitle: 'Credit Card Bill',
              amount: '\$2550.00',
              iconColor: Colors.teal,
            ),

            const SizedBox(height: 30),

            // View Transaction Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: onShowHistory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'View Transaction History',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}