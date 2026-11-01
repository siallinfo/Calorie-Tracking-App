import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calorie_tracking_app/app.dart';

void main() {
  testWidgets('shows the daily calorie summary and empty state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalorieTrackerApp());

    expect(find.text('Calorie Tracker'), findsOneWidget);
    expect(find.text('Your daily summary'), findsOneWidget);
    expect(find.text('Daily goal'), findsOneWidget);
    expect(find.text('Remaining'), findsOneWidget);
    expect(find.text('2000'), findsNWidgets(2));
    expect(find.text('Nothing added yet'), findsOneWidget);
  });

  testWidgets('adds food and updates totals, then deletes the food', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalorieTrackerApp());
    await tester.tap(find.text('Add food'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Oatmeal');
    await tester.enterText(find.byType(TextFormField).at(1), '320');
    await tester.tap(find.text('Add food').last);
    await tester.pumpAndSettle();

    expect(find.text('Oatmeal'), findsOneWidget);
    expect(find.text('320 kcal'), findsOneWidget);
    expect(find.text('320'), findsOneWidget);
    expect(find.text('1680'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete Oatmeal'));
    await tester.pumpAndSettle();

    expect(find.text('Oatmeal'), findsNothing);
    expect(find.text('Nothing added yet'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('2000'), findsNWidgets(2));
  });

  testWidgets('validates required fields and positive calories', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalorieTrackerApp());
    await tester.tap(find.text('Add food'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add food').last);
    await tester.pumpAndSettle();
    expect(find.text('Enter a food name'), findsOneWidget);
    expect(find.text('Enter a valid calorie amount'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Tea');
    await tester.enterText(find.byType(TextFormField).at(1), '0');
    await tester.tap(find.text('Add food').last);
    await tester.pumpAndSettle();

    expect(find.text('Calories must be greater than zero'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Tea'), findsNothing);
  });
}
