import 'package:afrilumina/Feature/countries/data/data.dart';

/// An abstract repository that defines the contract for fetching country-related data.
///
/// This repository acts as an intermediary between the data sources (remote/local)
/// and the business logic (use cases or BLoC), ensuring proper data handling.
abstract class CountryRepository {
  
  /// Fetches a list of all countries from the data source.
  ///
  /// Returns a `Future` that resolves to a list of `Country` objects.
  /// If the request fails, an error should be thrown.
  Future<List<Country>> getCountries();

  /// Fetches detailed information about a specific country.
  ///
  /// Requires the [countryName] as a parameter to retrieve details
  /// for the selected country.
  ///
  /// Returns a `Future` that resolves to a `CountryDetail` object.
  /// If the request fails, an error should be thrown.
  Future<CountryDetail> getCountryDetails(String countryName);
}


class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource countryRemoteDataSource;
  CountryRepositoryImpl({required this.countryRemoteDataSource});

  @override
  Future<List<Country>> getCountries() {
    try {
      return countryRemoteDataSource.getCountries();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CountryDetail> getCountryDetails(String countryName) {
    try {
      return countryRemoteDataSource.getCountryDetail(countryName);
    } catch (e) {
      rethrow;
    }
  }
}

CountryRepository get countryRepository =>
    CountryRepositoryImpl(countryRemoteDataSource: countryRemoteDataSource);
