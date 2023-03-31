import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';

class Pokemon {
  const Pokemon({
    required this.name,
  });

  final String name;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json["name"],
    );
  }

  Pokemon copyWith({
    String? name,
  }) {
    return Pokemon(
      name: name ?? this.name,
    );
  }
}
