import 'package:reactive_test/features/pokemons/domain/entity/pokemon_with_detail_container.dart';

abstract class PokemonService {
  fetchPokemons();

  Stream<List<PokemonWithDetailContainer>> observePokemons();

  fetchPokemonDetail(String name);

  Stream<PokemonWithDetailContainer> observePokemon(String name);
}
