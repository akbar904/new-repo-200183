
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/animal_model.dart';
import '../cubits/animal_cubit.dart';

class AnimalWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, AnimalState>(
			builder: (context, state) {
				final animal = state.animal;
				return GestureDetector(
					onTap: () => context.read<AnimalCubit>().toggleAnimal(),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(animal.name),
							Icon(animal.icon),
						],
					),
				);
			},
		);
	}
}