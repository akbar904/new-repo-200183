
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib/models/animal_model.dart';

void main() {
	group('Animal Model', () {
		test('Animal should have correct name and icon', () {
			final animal = Animal(name: 'Cat', icon: Icons.pets);

			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});

		test('Animal should serialize to JSON correctly', () {
			final animal = Animal(name: 'Dog', icon: Icons.person);

			final json = animal.toJson();

			expect(json['name'], 'Dog');
			expect(json['icon'], Icons.person.codePoint);
		});

		test('Animal should deserialize from JSON correctly', () {
			final json = {
				'name': 'Bird',
				'icon': Icons.air.codePoint,
			};

			final animal = Animal.fromJson(json);

			expect(animal.name, 'Bird');
			expect(animal.icon, Icons.air);
		});
	});
}
