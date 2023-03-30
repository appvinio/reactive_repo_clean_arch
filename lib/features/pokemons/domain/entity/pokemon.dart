import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';

class Pokemon {
  const Pokemon({
    required this.name,
    this.details,
  });

  final String name;
  final PokemonDetail? details;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json["name"],
    );
  }

  Pokemon copyWith({
    String? name,
    PokemonDetail? details,
  }) {
    return Pokemon(
      name: name ?? this.name,
      details: details ?? this.details,
    );
  }
}
