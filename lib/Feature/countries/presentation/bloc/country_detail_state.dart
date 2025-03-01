import 'package:afrilumina/Feature/countries/data/data.dart';

abstract class CountryDetailState{}

class CountryDetailInitial extends CountryDetailState{}
class CountryDetailLoading extends CountryDetailState {}
class CountryDetailLoaded extends CountryDetailState {
    final CountryDetail details;  
    CountryDetailLoaded(this.details);
}
class CountryDetailError extends CountryDetailState {
    final String message;
    CountryDetailError(this.message);
}

