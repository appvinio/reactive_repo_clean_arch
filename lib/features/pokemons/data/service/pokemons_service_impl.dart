import 'package:reactive_test/core/combine_any_latest_stream.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_detail_download.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_with_detail_container.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_detail_download_repository.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_detail_repository.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';
import 'package:reactive_test/features/pokemons/domain/service/pokemons_service.dart';
import 'package:rxdart/rxdart.dart';

class PokemonsServiceImpl implements PokemonService {
  const PokemonsServiceImpl({
    required this.detailDownloadRepository,
    required this.detailRepository,
    required this.mainRepository,
  });

  final PokemonsDetailDownloadRepository detailDownloadRepository;
  final PokemonsDetailRepository detailRepository;
  final PokemonsRepository mainRepository;

  @override
  fetchPokemonDetail(String name) async {
    final stream = detailRepository.fetchPokemonDetail(name);

    await for (PokemonDetailDownload progress in stream) {
      detailDownloadRepository.updateDownload(progress);
    }
  }

  @override
  fetchPokemons() {
    return mainRepository.fetchPokemons();
  }

  @override
  Stream<PokemonWithDetailContainer> observePokemon(String name) {
    final mainStream = mainRepository.observePokemon(name);
    final detailStream = detailRepository.observePokemon(name);
    final detailDownloadStream = detailDownloadRepository.observePokemon(name);

    return CombineAnyLatestStream([mainStream, detailStream, detailDownloadStream], (values) {
      return PokemonWithDetailContainer(
        main: values[0] as Pokemon,
        details: values[1] as PokemonDetail?,
        download: values[2] as PokemonDetailDownload?,
      );
    });
  }

  @override
  Stream<List<PokemonWithDetailContainer>> observePokemons() {
    final mainStream = mainRepository.observePokemons();
    final detailStream = detailRepository.observePokemonDetails();
    final detailDownloadStream = detailDownloadRepository.observePokemons();

    return CombineLatestStream([mainStream, detailStream, detailDownloadStream], (values) {
      final mainList = values[0] as List<Pokemon>;
      final detailList = values[1] as List<PokemonDetail>;
      final downloadList = values[2] as List<PokemonDetailDownload>;

      return mainList.map((e) {
        final detailIndex = detailList.indexWhere((element) => element.name == e.name);
        final downloadIndex = downloadList.indexWhere((element) => element.name == e.name);

        return PokemonWithDetailContainer(
          main: e,
          details: detailIndex != -1 ? detailList[detailIndex] : null,
          download: downloadIndex != -1 ? downloadList[downloadIndex] : null,
        );
      }).toList();
    });
  }
}
