import 'package:afrilumina/Feature/countries/data/data.dart';
import 'package:afrilumina/core/core.dart';
import 'package:afrilumina/utils/utils.dart';
import 'package:dio/dio.dart';

/// An abstract class that defines the contract for fetching country-related data 
/// from a remote source, such as an API.
///
/// Implementations of this class will handle the actual API requests
/// using an HTTP client like Dio.
abstract class CountryRemoteDataSource {
  
  /// Fetches a list of all countries from the remote data source.
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
  Future<CountryDetail> getCountryDetail(String countryName);
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final Dio dio;
  CountryRemoteDataSourceImpl({required this.dio});
  @override
  Future<List<Country>> getCountries() async {
    try {
      var response = await dio.get(
        'region/africa?status=true&fields=name,languages,capital,flags',
      );
      List<dynamic> payload = response.data;
      List<Country> countries =
          payload.map((element) => Country.fromJson(element)).toList();
      return countries;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<CountryDetail> getCountryDetail(String countryName) async {
    try {
      var response = await dio.get(
        '/name/$countryName',
      );
      List<dynamic> payload = response.data;
      return CountryDetail.fromJson(payload[0]);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}

CountryRemoteDataSource get countryRemoteDataSource =>
    CountryRemoteDataSourceImpl(dio: dioInstance);
