import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_test/features/pokemons/data/data_source/pokemon_remote_data_source.dart';
import 'package:reactive_test/features/pokemons/data/repository/pokemons_detail_download_repository_impl.dart';
import 'package:reactive_test/features/pokemons/data/repository/pokemons_detail_repository_impl.dart';
import 'package:reactive_test/features/pokemons/data/repository/pokemons_repository_impl.dart';
import 'package:reactive_test/features/pokemons/data/service/pokemons_service_impl.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_detail_download_repository.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_detail_repository.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';
import 'package:reactive_test/features/pokemons/domain/service/pokemons_service.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2/")));
  sl.registerSingleton<PokemonRemoteDataSource>(PokemonRemoteDataSource(dio: sl()));
  sl.registerSingleton<PokemonsRepository>(PokemonsRepositoryImpl(dataSource: sl()));
  sl.registerSingleton<PokemonsDetailRepository>(PokemonsDetailRepositoryImpl(dataSource: sl()));
  sl.registerSingleton<PokemonsDetailDownloadRepository>(PokemonsDetailDownloadRepositoryImpl());
  sl.registerSingleton<PokemonService>(PokemonsServiceImpl(
    detailDownloadRepository: sl(),
    detailRepository: sl(),
    mainRepository: sl(),
  ));
}
