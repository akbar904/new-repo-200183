
// test/animal_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animal_switcher/widgets/animal_widget.dart';

// Mock classes
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}
class FakeAnimalState extends Fake implements AnimalState {}

void main() {
	// Registering fake states to be used in tests
	setUpAll(() {
		registerFallbackValue(FakeAnimalState());
	});

	group('AnimalWidget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalWidget(),
						),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after tap', (WidgetTester tester) async {
			// Initial state
			when(() => animalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));
			// State after toggle
			whenListen(
				animalCubit,
				Stream.fromIterable([
					AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)),
					AnimalState(animal: Animal(name: 'Dog', icon: Icons.person))
				]),
			);

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalWidget(),
						),
					),
				),
			);

			// Initial state check
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);

			// Simulate tap
			await tester.tap(find.byType(AnimalWidget));
			await tester.pumpAndSettle();

			// Post-tap state check
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
