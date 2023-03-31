import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail_download.dart';

abstract class PokemonsDetailDownloadRepository {
  void updateDownload(PokemonDetailDownload element);

  Stream<List<PokemonDetailDownload>> observePokemons();

  Stream<PokemonDetailDownload> observePokemon(String name);
}
