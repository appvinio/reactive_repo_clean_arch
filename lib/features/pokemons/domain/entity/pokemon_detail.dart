class PokemonDetail {
  const PokemonDetail({
    required this.name,
    required this.height,
    required this.weight,
  });

  final String name;
  final int height;
  final int weight;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json["name"],
      height: json["height"],
      weight: json["weight"],
    );
  }
//
}
