import 'package:afrilumina/Feature/countries/presentation/bloc/bloc.dart';
import 'package:afrilumina/Feature/countries/presentation/screens/countries_screen.dart';
import 'package:afrilumina/core/core.dart';
import 'package:afrilumina/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/afriLumina_spash.png',
              height: 250,
              width: 250,
            ),
            BlocListener<CountryBloc, CountryState>(
              listener: (context, state) {
                if (state is CountryLoaded) {
                  Navigator.pushReplacementNamed(
                      context, CountriesScreen.routeName);
                }
              },
              child: BlocBuilder<CountryBloc, CountryState>(
                builder: (context, state) {
                  if (state is CountryLoading) {
                    return Shimmer.fromColors(
                      baseColor: AppColors.baseColor.shade600,
                      highlightColor: AppColors.highlightColor.shade400,
                      child: const Text(
                        'Welcome to AfriLumina',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (state is CountryError) {
                    return ErrorCard(
                      message: state.message,
                      retryAction: () =>
                          context.read<CountryBloc>().add(FetchCountryEvent()),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Discover the beauty and diversity of Africa",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
