import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Slightly off-white background
      // appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 75),

            // 1. Summary Cards
            Row(
              children: [
                _buildSummaryCard(
                  icon: Icons.arrow_downward_rounded,
                  label: 'Expense',
                  amount: '\$20,000.00',
                  isIncome: false,
                ),
                const SizedBox(width: 20),
                _buildSummaryCard(
                  icon: Icons.arrow_upward_rounded,
                  label: 'Income',
                  amount: '\$70,530.00',
                  isIncome: true,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 2. Custom Segmented Control
            _buildSegmentedControl(),
            const SizedBox(height: 15),

            // 3. Orange Chart Section
            _buildChartSection(),
            const SizedBox(height: 30),

            // 4. Transaction Section Header
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See all',
                  style: TextStyle(color: Colors.deepOrange, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // 5. Transaction List
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // leading: const Icon(Icons.arrow_back, color: Colors.black87),
      title: const Text(
        'History',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      // actions: const [
      //   Icon(Icons.more_vert, color: Colors.black87),
      //   SizedBox(width: 16),
      // ],
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String label,
    required String amount,
    required bool isIncome,
  }) {
    Color bgColor = isIncome ? Colors.deepOrange : Colors.grey.shade100;
    Color textColor = isIncome ? Colors.white : Colors.black87;
    Color iconColor = isIncome ? Colors.white : Colors.grey.shade600;

    return Expanded(
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 8),
                Text(label, style: TextStyle(color: textColor, fontSize: 14)),
              ],
            ),
            Text(
              amount,
              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSegment('Month', isActive: true),
          _buildSegment('Week', isActive: false),
          _buildSegment('Day', isActive: false),
        ],
      ),
    );
  }

  Widget _buildSegment(String label, {required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.deepOrange : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade600,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.deepOrange.shade700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: SmoothWavePainter(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Feb', style: TextStyle(color: Colors.white70)),
                Text('Mar', style: TextStyle(color: Colors.white70)),
                Text('Apr', style: TextStyle(color: Colors.white70)),
                Text('May', style: TextStyle(color: Colors.white70)),
                Text('Jun', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    // Mock Data based on your images
    final transactions = [
      {
        'icon': Icons.store_mall_directory_rounded,
        'title': 'ABC Mart',
        'time': 'Today, 12:30 PM',
        'amount': '-\$250.00',
        'isIncome': false
      },
      {
        'icon': Icons.business_rounded,
        'title': 'X Corp',
        'time': 'Yesterday, 9:00 AM',
        'amount': '+\$50,000.00',
        'isIncome': true
      },
      {
        'icon': Icons.coffee_maker_rounded,
        'title': 'Coffee Shop',
        'time': 'Mar 28, 3:15 PM',
        'amount': '-\$15.50',
        'isIncome': false
      },
      {
        'icon': Icons.sports_esports_rounded,
        'title': 'Gaming Store',
        'time': 'Mar 27, 7:45 PM',
        'amount': '-\$89.99',
        'isIncome': false
      },
    ];

    return Column(
      children: transactions.map((tx) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(tx['icon'] as IconData, color: Colors.indigo),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx['title'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    tx['time'] as String,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                tx['amount'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: (tx['isIncome'] as bool) ? Colors.teal : Colors.black87,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// --- Custom Painter for the Smooth Wave Chart ---

class SmoothWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Line Paint (White, smooth curve)
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Start slightly in from the left, mid-height
    path.moveTo(0, size.height * 0.65);

    // Using Cubic Bezier curves to create the smooth wave seen in image_2.png
    path.cubicTo(
      size.width * 0.2, size.height * 0.60, // Control point 1
      size.width * 0.3, size.height * 0.40, // Control point 2
      size.width * 0.4, size.height * 0.45, // First peak
    );

    path.cubicTo(
      size.width * 0.5, size.height * 0.50, // Control point 1
      size.width * 0.6, size.height * 0.25, // Control point 2
      size.width * 0.75, size.height * 0.30, // Main peak (Apr-May)
    );

    path.cubicTo(
      size.width * 0.85, size.height * 0.35, // Control point 1
      size.width * 0.95, size.height * 0.55, // Control point 2
      size.width, size.height * 0.50,         // End point
    );

    // 2. Draw the white outline curve
    canvas.drawPath(path, linePaint);

    // 3. Gradient Fill Paint
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height); // Bottom right
    fillPath.lineTo(0, size.height);          // Bottom left
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.2), // Faint glow near the line
          Colors.white.withOpacity(0.0), // Fades to orange at bottom
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // 4. Draw the subtle gradient fill below the curve
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}