import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final Function(String) onSearchChanged;

  SearchBar({required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search by Bank Number',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
