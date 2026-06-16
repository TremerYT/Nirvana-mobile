import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/core/services/business_service.dart';
import 'package:nirvana_mobile/features/business/models/business_model.dart';

class BusinessController extends GetxController {
  final BusinessService _businessService = BusinessService();

  var featuredBusinesses = <BusinessModel>[].obs;
  var searchResults = <BusinessModel>[].obs;
  var businesses = <BusinessModel>[].obs;
  var selectedBusiness = Rxn<BusinessModel>();

  var isLoadingFeatured = false.obs;
  var isLoadingSearch = false.obs;
  var isLoadingBusinesses = false.obs;
  var isLoadingProfile = false.obs;

  var featuredPage = 0;
  var searchPage = 0;
  var businessesPage = 0;
  var hasMoreFeatured = true.obs;
  var hasMoreSearch = true.obs;
  var hasMoreBusinesses = true.obs;

  var selectedCategory = 'ALL'.obs;
  var searchQuery = ''.obs;
  var hasError = false.obs;

  Timer? _debounceTimer;

  final searchController = TextEditingController();

  final categories = [
    'ALL',
    'ELECTRONICS',
    'FASHION',
    'FOOD',
    'BEAUTY',
    'HOME',
    'SPORTS',
    'OTHER',
  ];

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> retry() async {
    await loadInitialData();
  }

  Future<void> loadInitialData() async {
    hasError.value = false;
    await Future.wait([loadFeaturedBusinesses(), loadBusinesses()]);
  }

  Future<void> loadFeaturedBusinesses({bool refresh = false}) async {
    if (refresh) {
      featuredPage = 0;
      hasMoreFeatured.value = true;
      featuredBusinesses.clear();
    }
    if (!hasMoreFeatured.value) return;

    isLoadingFeatured.value = true;
    try {
      final results = await _businessService.getFeaturedBusinesses(
        page: featuredPage,
      );
      if (results.isEmpty) {
        hasMoreFeatured.value = false;
      } else {
        featuredBusinesses.addAll(results);
        featuredPage++;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoadingFeatured.value = false;
    }
  }

  Future<void> loadBusinesses({bool refresh = false}) async {
    if (refresh) {
      businessesPage = 0;
      hasMoreBusinesses.value = true;
      businesses.clear();
    }
    if (!hasMoreBusinesses.value) return;

    isLoadingBusinesses.value = true;
    try {
      List<BusinessModel> results;
      if (selectedCategory.value == "ALL") {
        results = await _businessService.getBusinesses(
          type: "",
          page: businessesPage,
        );
      } else {
        results = await _businessService.getBusinesses(
          type: selectedCategory.value,
          page: businessesPage,
        );
      }

      if (results.isEmpty) {
        hasMoreBusinesses.value = false;
      } else {
        businesses.addAll(results);
        businessesPage++;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoadingBusinesses.value = false;
    }
  }

  Future<void> onCategorySelect(String category) async {
    if (selectedCategory.value == category) return;
    selectedCategory.value = category;
    await loadBusinesses(refresh: true);
  }

  void search(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      clearSearch();
      return;
    }

    
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
    searchQuery.value = '';
    searchPage = 0;
    hasMoreSearch.value = true;
  }
}
