import 'package:reactive_test/core/base_data_controller.dart';
import 'package:reactive_test/features/pokemons/data/data_source/pokemon_remote_data_source.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';

class PokemonsRepositoryImpl extends BaseDataController<Pokemon> implements PokemonsRepository {
  PokemonsRepositoryImpl({
    required this.dataSource,
  });

  final PokemonRemoteDataSource dataSource;

  @override
  fetchPokemons() async {
    try {
      final pokemons = await dataSource.fetchPokemons();
      clear();
      addAll(pokemons);
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<List<Pokemon>> observePokemons() {
    return observeAll();
  }

  @override
  Stream<Pokemon> observePokemon(String name) {
    return observeSingle((element) => element.name == name);
  }
}
