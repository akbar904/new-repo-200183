
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:com.example.animal_switcher/main.dart';

void main() {
	group('Main App', () {
		testWidgets('Displays MyApp', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			// Verify if MyApp is displayed
			expect(find.byType(MyApp), findsOneWidget);
		});
	});
}
