
import 'package:afrilumina/Feature/countries/data/data.dart';
import 'package:flutter/material.dart';

Widget infoCard(
    IconData icon, String title, Map<dynamic, dynamic> values) {
  return Container(
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(icon, color: Colors.black54),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: values.entries.map((entry) {
                var key = entry.key;
                var value;

                if (entry.value is Currency) {
                  Currency currency = entry.value as Currency;
                  value = "${currency.name} (${currency.symbol})";
                } else {
                  value = entry.value.toString();
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    "${key}: ${value}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
