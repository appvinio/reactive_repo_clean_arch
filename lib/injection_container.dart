import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_test/features/pokemons/data/data_source/pokemon_remote_data_source.dart';
import 'package:reactive_test/features/pokemons/data/repository/pokemons_repository_impl.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2/")));
  sl.registerSingleton<PokemonRemoteDataSource>(PokemonRemoteDataSource(dio: sl()));
  sl.registerSingleton<PokemonsRepository>(PokemonsRepositoryImpl(dataSource: sl()));
}