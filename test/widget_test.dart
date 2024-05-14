// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/views/choose_location_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Find the icon correctly', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'favorite_cities': ['New York', 'Los Angeles'],
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: ChooseLocationPage(),
      ),
    );

    final iconfinder = find.byIcon(Icons.favorite_border);
    expect(iconfinder, findsWidgets);
  });
}
