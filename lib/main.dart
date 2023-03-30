import 'package:flutter/material.dart';
import 'package:reactive_test/features/pokemons/features/list/presentation/pokemons_list_page.dart';
import 'package:reactive_test/injection_container.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonsListPage(),
    );
  }
}
