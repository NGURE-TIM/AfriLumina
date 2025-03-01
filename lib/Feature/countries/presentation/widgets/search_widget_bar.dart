
import 'package:afrilumina/Feature/countries/data/data.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final List<Country> countries;
  final Function(List<Country>) filterResult;

  const SearchBarWidget(this.countries, this.filterResult, {super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final filteredResults = widget.countries
        .where((country) =>
            country.countryName.toLowerCase().contains(query) ||
            country.countryCapital.toLowerCase().contains(query))
        .toList();

    widget.filterResult(filteredResults);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            isFocused = hasFocus;
          });
        },
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search country...",
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.deepOrange,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black54),
                    onPressed: () {
                      _searchController.clear();
                      widget.filterResult(widget.countries);
                      setState(() {});
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color:
                    isFocused ? Colors.deepOrange.shade600 : Colors.transparent,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.deepOrange.shade600,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}