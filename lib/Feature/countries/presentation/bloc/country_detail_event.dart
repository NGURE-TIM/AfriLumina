abstract class CountryDetailEvent {}

class FetchCountryDetailsEvent extends CountryDetailEvent{
  final String countryName;
  FetchCountryDetailsEvent(this.countryName);
}