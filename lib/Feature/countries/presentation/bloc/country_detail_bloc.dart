import 'package:afrilumina/Feature/countries/data/data.dart';
import 'package:afrilumina/Feature/countries/presentation/bloc/country_detail_event.dart';
import 'package:afrilumina/Feature/countries/presentation/bloc/country_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final CountryRepository countryRepository;

  /// Initializes the `CountryDetailBloc` with the given [countryRepository].

  CountryDetailBloc({required this.countryRepository})
      : super(CountryDetailInitial()) {
    /// - Uses a delay of 1 second to simulate loading (optional).

    on<FetchCountryDetailsEvent>((event, emit) async {
      emit(CountryDetailLoading());
      try {
        await Future.delayed(const Duration(seconds: 1)); // Simulated delay
        final CountryDetail countryDetail =
            await countryRepository.getCountryDetails(event.countryName);
        emit(CountryDetailLoaded(countryDetail));
      } catch (e) {
        emit(CountryDetailError(e.toString()));
      }
    });
  }
}
