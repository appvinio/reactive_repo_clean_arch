import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';

abstract class PokemonsRepository {
  fetchPokemons();

  Stream<List<Pokemon>> observePokemons();

  Stream<Pokemon> observePokemon(String name);

}