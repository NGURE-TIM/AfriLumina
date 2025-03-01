import 'package:afrilumina/core/core.dart';
import 'package:afrilumina/utils/utils.dart' as mapsutils;
import 'package:flutter/material.dart';

import 'widgets.dart';

class CountryInfoCard extends StatelessWidget {
  final double population;
  final String phoneCode;
  final double latitude;
  final double longitude;

  const CountryInfoCard({
    Key? key,
    required this.population,
    required this.phoneCode,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Other country details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            infoRow(Icons.people, "Population", population.toString()),
            infoRow(Icons.phone, "Phone Code", phoneCode),
            infoRow(Icons.location_on, "Geographic Location",
                "Lat: $latitude, Lng: $longitude"),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () =>
                    mapsutils.openMap(latitude, longitude).catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Oops! unable to launch maps",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: AppColors.baseColor.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text("View on Map",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.baseColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
