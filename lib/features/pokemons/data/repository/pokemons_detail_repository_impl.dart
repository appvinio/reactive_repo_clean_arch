import 'package:reactive_test/core/base_data_controller.dart';
import 'package:reactive_test/features/pokemons/data/data_source/pokemon_remote_data_source.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail_download.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_detail_repository.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';

class PokemonsDetailRepositoryImpl extends BaseDataController<PokemonDetail> implements PokemonsDetailRepository {
  PokemonsDetailRepositoryImpl({
    required this.dataSource,
  });

  final PokemonRemoteDataSource dataSource;

  @override
  Stream<PokemonDetailDownload> fetchPokemonDetail(String name) async* {
    yield PokemonDetailDownload(name: name, progress: 0.0);
    try {
      await Future.delayed(const Duration(seconds: 1));
      yield PokemonDetailDownload(name: name, progress: 0.25);
      await Future.delayed(const Duration(seconds: 1));
      final pokemonDetail = await dataSource.fetchPokemonDetail(name);
      addOrUpdate(pokemonDetail, (element) => element.name == name);
      yield PokemonDetailDownload(name: name, progress: 0.50);
      await Future.delayed(const Duration(seconds: 1));
      yield PokemonDetailDownload(name: name, progress: 0.75);
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print(e);
    }
    yield PokemonDetailDownload(name: name, progress: 1.0);
  }

  @override
  Stream<PokemonDetail> observePokemon(String name) {
    return observeSingle((element) => element.name == name);
  }

  @override
  Stream<List<PokemonDetail>> observePokemonDetails() {
    return observeAll();
  }
}
