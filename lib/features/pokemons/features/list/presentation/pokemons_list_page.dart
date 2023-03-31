import 'package:flutter/material.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon_with_detail_container.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';
import 'package:reactive_test/features/pokemons/domain/service/pokemons_service.dart';
import 'package:reactive_test/features/pokemons/features/detail/presentation/pokemons_detail_page.dart';
import 'package:reactive_test/injection_container.dart';

class PokemonsListPage extends StatelessWidget {
  const PokemonsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reactive"),
      ),
      body: StreamBuilder<List<PokemonWithDetailContainer>>(
        stream: sl<PokemonService>().observePokemons(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final data = snapshot.data ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final pokemon = data[index];
                    final detail = pokemon.details;
                    final download = pokemon.download;
                    return ListTile(
                      title: Text(pokemon.main.name),
                      subtitle: Text("Has details: ${detail != null}"),
                      trailing: Text(download != null ? "${download.progress*100}%" : ""),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PokemonsDetailPage(pokemonName: pokemon.main.name),
                      )),
                    );
                  },
                  itemCount: data.length,
                );
              } else {
                return SizedBox.shrink();
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sl<PokemonService>().fetchPokemons(),
      ),
    );
  }
}
