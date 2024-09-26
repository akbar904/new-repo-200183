
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/models/animal_model.dart';

class AnimalState {
	final Animal animal;

	AnimalState(this.animal);
}

class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(AnimalState(Animal('cat', Icons.access_time)));

	void toggleAnimal() {
		final currentAnimal = state.animal;
		if (currentAnimal.name == 'cat') {
			emit(AnimalState(Animal('dog', Icons.person)));
		} else {
			emit(AnimalState(Animal('cat', Icons.access_time)));
		}
	}
}
