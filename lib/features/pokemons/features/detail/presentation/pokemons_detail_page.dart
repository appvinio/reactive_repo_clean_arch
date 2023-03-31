import 'package:flutter/material.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_with_detail_container.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';
import 'package:reactive_test/features/pokemons/domain/service/pokemons_service.dart';
import 'package:reactive_test/injection_container.dart';

class PokemonsDetailPage extends StatelessWidget {
  const PokemonsDetailPage({
    required this.pokemonName,
    Key? key,
  }) : super(key: key);

  final String pokemonName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reactive $pokemonName"),
      ),
      body: StreamBuilder<PokemonWithDetailContainer>(
        stream: sl<PokemonService>().observePokemon(pokemonName),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final data = snapshot.data;
                if (data != null) {
                  final details = data.details;
                  final download = data.download;
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (details != null)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Weight: ${details.weight}"),
                              Text("Height: ${details.height}"),
                            ],
                          ),
                        if (download != null)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Progress ${download.progress * 100}%"),
                              LinearProgressIndicator(
                                value: download.progress,
                              ),
                            ],
                          )
                      ],
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sl<PokemonService>().fetchPokemonDetail(pokemonName),
      ),
    );
  }
}
