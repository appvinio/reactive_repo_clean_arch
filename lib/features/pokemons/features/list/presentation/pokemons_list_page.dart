import 'package:flutter/material.dart';
import 'package:reactive_test/features/pokemons/domain/entity/pokemon.dart';
import 'package:reactive_test/features/pokemons/domain/repository/pokemons_repository.dart';
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
      body: StreamBuilder<List<Pokemon>>(
        stream: sl<PokemonsRepository>().observePokemons(),
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
                    return ListTile(
                      title: Text(pokemon.name),
                      subtitle: Text("Has details: ${pokemon.details != null}"),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PokemonsDetailPage(pokemonName: pokemon.name),
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
        onPressed: () => sl<PokemonsRepository>().fetchPokemons(),
      ),
    );
  }
}
