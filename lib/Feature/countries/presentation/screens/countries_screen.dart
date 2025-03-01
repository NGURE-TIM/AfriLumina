import 'package:afrilumina/Feature/countries/data/data.dart';
import 'package:afrilumina/Feature/countries/presentation/widgets/widgets.dart';
import 'package:afrilumina/core/core.dart';
import 'package:afrilumina/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afrilumina/Feature/countries/presentation/bloc/bloc.dart';

class CountriesScreen extends StatefulWidget {
  static const String routeName = "/countries";

  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List<Country> filteredCountries = [];
  Future<void> refreshScreen(BuildContext context) async {
    context.read<CountryBloc>().add(FetchCountryEvent());
    return;
  }

  void filterCountries(List<Country> filteredResults) {
    setState(() {
      filteredCountries = filteredResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.highlightColor.shade400,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.highlightColor.shade400,
                        AppColors.baseColor.shade600
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "🌍 Explore Africa",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Discover African Nations",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Browse through countries across the African continent and learn about their flags, capitals, and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ),
                BlocBuilder<CountryBloc, CountryState>(
                    builder: (context, state) {
                  if (state is CountryLoaded) {
                    return SearchBarWidget(state.countries, filterCountries);
                  }
                  return SearchBarWidget([], filterCountries);
                }),
                BlocBuilder<CountryBloc, CountryState>(
                  builder: (context, state) {
                    if (state is CountryLoading) {
                      return Expanded(
                          child: LoadingCountryGrid(refreshScreen, context));
                    } else if (state is CountryLoaded) {
                      return Expanded(
                          child: CountryGrid(
                              countries: filteredCountries.isNotEmpty
                                  ? filteredCountries
                                  : state.countries,
                              refreshData: refreshScreen,
                              context: context));
                    } else if (state is CountryError) {
                      return ErrorCard(
                        message: state.message,
                        retryAction: () => context
                            .read<CountryBloc>()
                            .add(FetchCountryEvent()),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
