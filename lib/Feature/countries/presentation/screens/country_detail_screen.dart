import 'package:afrilumina/Feature/countries/presentation/widgets/widgets.dart';
import 'package:afrilumina/core/core.dart';
import 'package:afrilumina/utils/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afrilumina/Feature/countries/presentation/bloc/bloc.dart';

class CountriesDetailsScreen extends StatefulWidget {
  static const String routeName = "/countries-details";
  final String? countryName;
  final String? imageUrl;
  final String? imageAltText;
  const CountriesDetailsScreen(
      {this.countryName, this.imageUrl, this.imageAltText});

  @override
  State<CountriesDetailsScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CountryDetailBloc>()
        .add(FetchCountryDetailsEvent(widget.countryName!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.highlightColor.shade400,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:const Icon(Icons.arrow_back_ios, color: AppColors.baseColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<CountryDetailBloc, CountryDetailState>(
              builder: (context, state) {
                if (state is CountryDetailLoading) {
                  return const LoadingCountryDetail();
                } else if (state is CountryDetailLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Africa / ${state.details.countrySubRegion}",
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.countryName!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      NetworkImageWidget(
                        imageUrl: widget.imageUrl!,
                        imageAltText: widget.imageAltText!,
                        height: 140,
                        width: double.infinity,
                      ),
                      infoCard(Icons.language, "Languages",
                          state.details.countryLanguages),
                      infoCard(Icons.account_balance, "Currencies",
                          state.details.countryCurrencies),
                      CountryInfoCard(
                        population: state.details.countryPopulation,
                        phoneCode: state.details.countryDialCode,
                        latitude: state.details.countryCoordinates[0],
                        longitude: state.details.countryCoordinates[1],
                      )
                    ],
                  );
                } else if (state is CountryDetailError) {
                  return Center(
                    child: ErrorCard(
                      message: state.message,
                      retryAction: () => context
                          .read<CountryDetailBloc>()
                          .add(FetchCountryDetailsEvent(widget.countryName!)),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
