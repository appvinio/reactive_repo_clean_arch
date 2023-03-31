import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail_download.dart';

class PokemonWithDetailContainer {
  final Pokemon main;
  final PokemonDetail? details;
  final PokemonDetailDownload? download;

  const PokemonWithDetailContainer({
    required this.main,
    required this.details,
    required this.download,
  });
}