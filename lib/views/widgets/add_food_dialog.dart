import 'package:flutter/material.dart';

import '../../models/food_entry.dart';

class AddFoodDialog extends StatefulWidget {
  const AddFoodDialog({super.key});

  @override
  State<AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      FoodEntry(
        name: _nameController.text.trim(),
        calories: double.parse(_caloriesController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add food'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Food name',
                hintText: 'e.g. Avocado toast',
                prefixIcon: Icon(Icons.restaurant_outlined),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter a food name'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _caloriesController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Calories',
                hintText: 'e.g. 320',
                suffixText: 'kcal',
                prefixIcon: Icon(Icons.local_fire_department_outlined),
              ),
              validator: (value) {
                final calories = double.tryParse(value?.trim() ?? '');
                if (calories == null || !calories.isFinite) {
                  return 'Enter a valid calorie amount';
                }
                if (calories <= 0) {
                  return 'Calories must be greater than zero';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Add food')),
      ],
    );
  }
}
