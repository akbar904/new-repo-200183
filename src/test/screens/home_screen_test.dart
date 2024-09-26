
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/screens/home_screen.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/models/animal_model.dart';

// Mocking AnimalCubit for testing
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			// Arrange
			Animal cat = Animal(name: 'Cat', icon: Icons.access_time);
			when(() => animalCubit.state).thenReturn(cat);

			// Act
			await tester.pumpWidget(MaterialApp(
				home: BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: HomeScreen(),
				),
			));

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon when clicked', (WidgetTester tester) async {
			// Arrange
			Animal cat = Animal(name: 'Cat', icon: Icons.access_time);
			Animal dog = Animal(name: 'Dog', icon: Icons.person);
			when(() => animalCubit.state).thenReturn(cat);
			whenListen(animalCubit, Stream.fromIterable([cat, dog]));

			// Act
			await tester.pumpWidget(MaterialApp(
				home: BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: HomeScreen(),
				),
			));

			// Click the AnimalWidget
			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
