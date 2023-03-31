import 'package:reactive_test/core/base_data_controller.dart';
import 'package:reactive_test/features/pokemons/data/data_source/pokemon_remote_data_source.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail_download.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_detail_download_repository.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_detail_repository.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';

class PokemonsDetailDownloadRepositoryImpl extends BaseDataController<PokemonDetailDownload>
    implements PokemonsDetailDownloadRepository {
  @override
  Stream<PokemonDetailDownload> observePokemon(String name) {
    return observeSingle((element) => element.name == name);
  }

  @override
  Stream<List<PokemonDetailDownload>> observePokemons() {
    return observeAll();
  }

  @override
  void updateDownload(PokemonDetailDownload download) {
    addOrUpdate(download, (element) => element.name == download.name);
  }
}
