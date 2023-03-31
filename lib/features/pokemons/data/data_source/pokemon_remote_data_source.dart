import 'package:dio/dio.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';

class PokemonRemoteDataSource {
  final Dio dio;

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await dio.get("pokemon?limit=100000&offset=0");
    final pokemonList = (response.data as Map<String, dynamic>)['results'] as List;
    final pokemons = pokemonList.map((e) => Pokemon.fromJson(e)).toList();

    return pokemons;
  }

  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final response = await dio.get("pokemon/$name");
    return PokemonDetail.fromJson(response.data as Map<String, dynamic>);
  }

  const PokemonRemoteDataSource({
    required this.dio,
  });
}
