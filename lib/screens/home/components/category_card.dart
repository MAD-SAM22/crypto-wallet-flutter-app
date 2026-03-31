import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"name": "DeFi", "count": "234 coins", "icon": "💰", "color": const Color(0xFFE8F5E9)}, // Light Green
      {"name": "NFT", "count": "156 coins", "icon": "🎨", "color": const Color(0xFFF3E5F5)}, // Light Purple
      {"name": "Gaming", "count": "89 coins", "icon": "🎮", "color": const Color(0xFFE3F2FD)}, // Light Blue
      {"name": "Metaverse", "count": "67 coins", "icon": "🌐", "color": const Color(0xFFE8EAF6)}, // Light Indigo
      {"name": "Exchange", "count": "45 coins", "icon": "🔄", "color": const Color(0xFFFFF3E0)}, // Light Orange
      {"name": "Gold", "count": "123 coins", "icon": "🪙", "color": const Color(0xFFFFFDE7)}, // Light Yellow
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 0),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];
              return _buildCategoryCard(item);
            },
          ),
        ),
      ],
    );
  }

  // Individual Card Component
  Widget _buildCategoryCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular Icon Background
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: item["color"],
              shape: BoxShape.circle,
            ),
            child: Text(
              item["icon"],
              style: const TextStyle(fontSize: 26),
            ),
          ),
          const SizedBox(height: 12),
          // Category Name
          Text(
            item["name"],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          // Coin Count
          Text(
            item["count"],
            style: TextStyle(
              fontSize: 13,
              color: Colors.blueGrey[400],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}