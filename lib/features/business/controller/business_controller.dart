import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:nirvana_mobile/core/services/business_service.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
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

  Timer? _searchDebounce;
  final searchController = TextEditingController();
  final scrollController = ScrollController();

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
    scrollController.addListener(_onScroll);
    loadInitialData();
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 300) {
      loadBusinesses();
    }
  }

  Future<void> retry() async {
    await loadInitialData();
  }

  Future<void> loadInitialData() async {
    hasError.value = false;
    await Future.wait([
      loadFeaturedBusinesses(refresh: true),
      loadBusinesses(refresh: true),
    ]);
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
      Fluttertoast.showToast(
        msg: "Failed to load featured businesses",
        gravity: ToastGravity.TOP,
      );
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

    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      searchPage = 0;
      hasMoreSearch.value = true;
      searchResults.clear();
      isLoadingSearch.value = true;

      try {
        final results = await _businessService.getBusinessBySearch(
          query: query,
          page: searchPage,
        );
        if (results.isEmpty) {
          hasMoreSearch.value = false;
        } else {
          searchResults.addAll(results);
          searchPage++;
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString().replaceFirst('Exception: ', ''),
          backgroundColor: AppColors.error,
          gravity: ToastGravity.TOP,
        );
      } finally {
        isLoadingSearch.value = false;
      }
    });
  }

  Future<void> loadBusinessById(int id) async {
    isLoadingProfile.value = true;
    try {
      final business = await _businessService.getBusinessById(id);
      selectedBusiness.value = business;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
      );
    } finally {
      isLoadingProfile.value = false;
    }
  }

  Future<void> toggleFollow(int businessId) async {
    final current = selectedBusiness.value;
    if (current == null || current.id != businessId) return;

    final wasFollowing = current.isFollowing;
    selectedBusiness.value = _copyWith(
      current,
      isFollowing: !wasFollowing,
      followerCount: wasFollowing
          ? current.followerCount - 1
          : current.followerCount + 1,
    );

    try {
      await _businessService.followBusiness(businessId);
    } catch (e) {
      selectedBusiness.value = _copyWith(
        current,
        isFollowing: wasFollowing,
        followerCount: current.followerCount,
      );
      Fluttertoast.showToast(msg: "Failed to update follow status");
    }
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
    searchQuery.value = '';
    searchPage = 0;
    hasMoreSearch.value = true;
  }

  BusinessModel _copyWith(
    BusinessModel current, {
    bool? isFollowing,
    int? followerCount,
  }) {
    return BusinessModel(
      id: current.id,
      businessName: current.businessName,
      businessDescription: current.businessDescription,
      businessLocation: current.businessLocation,
      verificationStatus: current.verificationStatus,
      currentPlan: current.currentPlan,
      followerCount: followerCount ?? current.followerCount,
      isFollowing: isFollowing ?? current.isFollowing,
      isFeatured: current.isFeatured,
      categories: current.categories,
    );
  }
}
