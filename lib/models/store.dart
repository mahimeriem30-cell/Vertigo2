String _getDefaultCategory() {
  return 'Boutique';
}

class Store {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String address;
  final double rating;
  final double distance;

  Store({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.address,
    required this.rating,
    required this.distance,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['idBoutique'].toString(),
      name: json['nomBoutique'],
      category: _getDefaultCategory(), // ← Valeur par défaut
      imageUrl: json['boutiqueImagePath'] ?? '',
      address: json['localisation'] ?? '',
      rating: (json['note'] as num?)?.toDouble() ?? 0.0,
      distance: 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'idBoutique': int.tryParse(id) ?? 0,
    'nomBoutique': name,
    'boutiqueImagePath': imageUrl,
    'localisation': address,
    'note': rating,
  };
}
