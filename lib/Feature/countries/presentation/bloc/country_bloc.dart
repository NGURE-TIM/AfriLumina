import 'package:afrilumina/Feature/countries/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository countryRepository;

  /// Initializes the `CountryBloc` with the given [countryRepository].
  CountryBloc({required this.countryRepository}) : super(CountryInitial()) {
    /// Handles the `FetchCountryEvent` to retrieve a list of countries.
    ///
    /// - Uses a delay of 2 seconds to simulate loading (optional).
    on<FetchCountryEvent>((event, emit) async {
      emit(CountryLoading());
      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulated delay
        final List<Country> countries = await countryRepository.getCountries();
        emit(CountryLoaded(countries));
      } catch (e) {
        emit(CountryError(e.toString()));
      }
    });
  }
}
