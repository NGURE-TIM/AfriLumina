import 'package:afrilumina/Feature/countries/presentation/screens/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Feature/countries/data/data.dart';
import 'Feature/countries/presentation/bloc/bloc.dart';
import 'Feature/countries/presentation/presentation.dart';
import 'Feature/countries/presentation/screens/countries_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CountryBloc(countryRepository: countryRepository)
          ..add(FetchCountryEvent()),
      ),
      BlocProvider(
        create: (context) => CountryDetailBloc (countryRepository: countryRepository),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        CountriesScreen.routeName: (context) => const CountriesScreen(),
        CountriesDetailsScreen.routeName: (context) =>  CountriesDetailsScreen(),
      },
    );
  }
}
