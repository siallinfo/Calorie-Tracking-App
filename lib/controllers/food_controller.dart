import 'package:flutter/foundation.dart';

import '../models/food_entry.dart';

class FoodController extends ChangeNotifier {
  static const double dailyGoal = 2000;

  final List<FoodEntry> _foods = [];

  List<FoodEntry> get foods => List.unmodifiable(_foods);

  double get totalCalories =>
      _foods.fold(0, (total, food) => total + food.calories);

  double get remainingCalories =>
      (dailyGoal - totalCalories).clamp(0.0, dailyGoal).toDouble();

  double get progress => (totalCalories / dailyGoal).clamp(0.0, 1.0).toDouble();

  void addFood(FoodEntry food) {
    _foods.add(food);
    notifyListeners();
  }

  void removeFoodAt(int index) {
    _foods.removeAt(index);
    notifyListeners();
  }
}
