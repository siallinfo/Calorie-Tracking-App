import 'package:flutter/material.dart';

import '../../controllers/food_controller.dart';
import '../../models/food_entry.dart';
import '../widgets/add_food_dialog.dart';
import '../widgets/empty_food_list.dart';
import '../widgets/summary_card.dart';

class CalorieHomeScreen extends StatefulWidget {
  const CalorieHomeScreen({super.key});

  @override
  State<CalorieHomeScreen> createState() => _CalorieHomeScreenState();
}

class _CalorieHomeScreenState extends State<CalorieHomeScreen> {
  final FoodController _foodController = FoodController();

  @override
  void dispose() {
    _foodController.dispose();
    super.dispose();
  }

  String get _todayLabel {
    final now = DateTime.now();
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  String _formatCalories(double calories) {
    if (calories == calories.roundToDouble()) {
      return calories.toStringAsFixed(0);
    }
    return calories
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  Future<void> _showAddFoodDialog() async {
    final food = await showDialog<FoodEntry>(
      context: context,
      builder: (context) => const AddFoodDialog(),
    );

    if (food != null && mounted) {
      _foodController.addFood(food);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _foodController,
      builder: (context, _) => _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final foods = _foodController.foods;
    final totalCalories = _foodController.totalCalories;
    final remainingCalories = _foodController.remainingCalories;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4F1E9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.eco_outlined,
                      color: Color(0xFF1F6B4E),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Calorie Tracker',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              _todayLabel,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: const Color(0xFF647067)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Your daily summary',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      label: 'Total',
                      value: _formatCalories(totalCalories),
                      icon: Icons.local_fire_department_outlined,
                      color: const Color(0xFF1F6B4E),
                      background: const Color(0xFFE5F2E9),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(
                      label: 'Daily goal',
                      value: _formatCalories(FoodController.dailyGoal),
                      icon: Icons.flag_outlined,
                      color: const Color(0xFF355C9A),
                      background: const Color(0xFFEAF0FA),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(
                      label: 'Remaining',
                      value: _formatCalories(remainingCalories),
                      icon: Icons.spa_outlined,
                      color: const Color(0xFF9A6424),
                      background: const Color(0xFFFFF2DF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Daily progress',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${(_foodController.progress * 100).round()}%',
                            style: const TextStyle(
                              color: Color(0xFF1F6B4E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _foodController.progress,
                          minHeight: 9,
                          backgroundColor: const Color(0xFFE8ECE8),
                          color: const Color(0xFF2C8A62),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        totalCalories > FoodController.dailyGoal
                            ? '${_formatCalories(totalCalories - FoodController.dailyGoal)} kcal over your goal'
                            : '${_formatCalories(remainingCalories)} kcal left for today',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: const Color(0xFF738077)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Today’s food',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _showAddFoodDialog,
                    icon: const Icon(Icons.add, size: 19),
                    label: const Text('Add food'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: foods.isEmpty ? 1 : foods.length,
                  itemBuilder: (context, index) {
                    if (foods.isEmpty) return const EmptyFoodList();

                    final food = foods[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                        leading: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F4EF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Color(0xFF50745D),
                            size: 21,
                          ),
                        ),
                        title: Text(
                          food.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${_formatCalories(food.calories)} kcal',
                          style: const TextStyle(color: Color(0xFF738077)),
                        ),
                        trailing: IconButton(
                          tooltip: 'Delete ${food.name}',
                          onPressed: () => _foodController.removeFoodAt(index),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Color(0xFF9A5E58),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
