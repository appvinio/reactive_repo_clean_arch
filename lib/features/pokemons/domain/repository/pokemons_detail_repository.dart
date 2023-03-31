import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail_download.dart';

abstract class PokemonsDetailRepository {
  Stream<PokemonDetailDownload> fetchPokemonDetail(String name);

  Stream<List<PokemonDetail>> observePokemonDetails();

  Stream<PokemonDetail> observePokemon(String name);
}
