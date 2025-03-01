
import 'package:afrilumina/Feature/countries/data/data.dart';
import 'package:afrilumina/Feature/countries/presentation/screens/country_detail_screen.dart';
import 'package:afrilumina/core/core.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

Widget CountryGrid(
    {required List<Country> countries,
    required Function refreshData,
    required BuildContext context}) {
  return RefreshIndicator(
    color: AppColors.baseColor,
    onRefresh: () => refreshData(context),
    child: GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: countries.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) => ItemTile(countries[index]),
    ),
  );
}

class ItemTile extends StatelessWidget {
  final Country countryItem;

  const ItemTile(this.countryItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountriesDetailsScreen(
              countryName: countryItem.countryName,
              imageUrl: countryItem.countryFlagUrl,
              imageAltText: countryItem.countryFlagAltText,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: NetworkImageWidget(
                  imageUrl: countryItem.countryFlagUrl,
                  imageAltText: countryItem.countryFlagAltText,
                  height: 90,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  countryItem.countryName.trim(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  countryItem.countryCapital.trim(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
