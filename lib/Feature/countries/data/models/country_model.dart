class Country {
  final String countryName;
  final String countryFlagUrl;
  final String countryFlagAltText;
  final String countryCapital;

  Country({
    required this.countryName,
    required this.countryFlagUrl,
    required this.countryFlagAltText,
    required this.countryCapital,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryName: json['name']?['common'] ?? 'country name not available',
      countryFlagUrl: json['flags']?['png'] ?? '',
      countryFlagAltText: json['flags']?['alt'] ?? 'No description available',
      countryCapital: json['capital']?[0] ?? 'No capital available',
    );
  }
}