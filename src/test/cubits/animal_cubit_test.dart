
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is AnimalState(cat)', () {
			expect(animalCubit.state, equals(AnimalState(cat)));
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(dog)] when toggleAnimal is called and current state is cat',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(dog)],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(cat)] when toggleAnimal is called and current state is dog',
			build: () => animalCubit,
			seed: () => AnimalState(dog),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(cat)],
		);
	});
}
