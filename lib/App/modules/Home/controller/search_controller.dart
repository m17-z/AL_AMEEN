import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchControllerView extends GetxController {
  final searchText = ''.obs;
  final searchController = TextEditingController();

  void updateSearchText(String text) {
    searchText.value = text;
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
  }
}