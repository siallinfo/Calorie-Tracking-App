import 'package:flutter/material.dart';

class EmptyFoodList extends StatelessWidget {
  const EmptyFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1EB),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.no_food_outlined,
              color: Color(0xFF52745D),
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nothing added yet',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text(
            'Add your first meal to start tracking.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF738077)),
          ),
        ],
      ),
    );
  }
}
