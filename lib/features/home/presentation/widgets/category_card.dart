import 'package:flutter/material.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final ApiService _apiService = ApiService();
  late Future<ApiResult<List<dynamic>>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    // Use the categories endpoint for market data (counts/ids)
    _categoriesFuture = _apiService.getCategoriesList();
  }

  Map<String, dynamic> _getStyle(String id) {
    final styles = {
      '0g-ecosystem': {'icon': '🌐', 'color': const Color(0xFFE3F2FD)},      // Blue
      '4chan-themed': {'icon': '🍀', 'color': const Color(0xFFE8F5E9)},      // Green
      '8bit-chain-ecosystem': {'icon': '👾', 'color': const Color(0xFFF3E5F5)}, // Purple
      'aarna-vault-tokens': {'icon': '🔓', 'color': const Color(0xFFFFF3E0)},   // Orange
      'aave-tokens': {'icon': '👻', 'color': const Color(0xFFE0F7FA)},          // Cyan
      'abstract-ecosystem': {'icon': '✨', 'color': const Color(0xFFE8EAF6)},   // Indigo
    };

    return styles[id] ?? {'icon': '💎', 'color': const Color(0xFFF5F5F5)};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResult<List<dynamic>>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ));
        }

        final result = snapshot.data;
        if (result is Success) {
          // Take exactly 6 as requested
          final List data = (result?.data as List).take(6).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
              itemCount: data.length,
              itemBuilder: (context, index) {
                final category = data[index];

                final String id = category['category_id'] ?? category['id'] ?? '';
                final String name = category['name'] ?? 'Unknown';

                final style = _getStyle(id);
                final String count = category['coins_count'] != null
                    ? "${category['coins_count']} coins"
                    : "-- coins";

                return _buildCategoryCard(
                  name: name,
                  count: count,
                  icon: style['icon'],
                  color: style['color'],
                );
              },
            ),
          );
        }

        return const SizedBox.shrink(); // Hide if error or empty
      },
    );
  }

  Widget _buildCategoryCard({
    required String name,
    required String count,
    required String icon,
    required Color color
  }) {
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              icon,
              style: const TextStyle(fontSize: 26),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey[400],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}