class CountryDetail {
  final Map<String, Currency> countryCurrencies;
  final String countryDialCode;
  final String countrySubRegion;
  final double countryPopulation;
  final List<double> countryCoordinates;
  final Map<String, String> countryLanguages;

  CountryDetail({
    required this.countryCurrencies,
    required this.countryDialCode,
    required this.countrySubRegion,
    required this.countryPopulation,
    required this.countryCoordinates,
    required this.countryLanguages,
  });

  factory CountryDetail.fromJson(Map<String, dynamic> json) {
    return CountryDetail(
      countryCurrencies: (json['currencies'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key, 
              Currency.fromJson(value as Map<String, dynamic>),
            ),
          ) ?? {},
      countryDialCode: (json['idd']?['root'] ?? '') + (json['idd']?['suffixes']?.first ?? ''),
      countrySubRegion: json['subregion'] ?? 'Subregion not available',
      countryPopulation: (json['population'] as num?)?.toDouble() ?? 0.0,
      countryCoordinates: (json['capitalInfo']?['latlng'] as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList() ?? [0.0, 0.0],
      countryLanguages: (json['languages'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, value.toString()),
          ) ?? {},
    );
  }
}

class Currency {
  final String name;
  final String symbol;

  Currency({required this.name, required this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'] ?? 'Unknown',
      symbol: json['symbol'] ?? '',
    );
  }
}
