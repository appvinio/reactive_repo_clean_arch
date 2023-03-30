class PokemonDetail {
  const PokemonDetail({
    required this.height,
    required this.weight,
  });

  final int height;
  final int weight;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      height: json["height"],
      weight: json["weight"],
    );
  }
//
}
