class BusinessModel {
  final int id;
  final String businessName;
  final String businessDescription;
  final String businessLocation;
  final String? backgroundUrl;
  final String? backgroundLogo;
  final String verificationStatus;
  final String? currentPlan;
  final int followerCount;
  final bool isFollowing;
  final bool isFeatured;
  final List<String> categories;

  BusinessModel({
    required this.businessName,
    required this.businessDescription,
    required this.businessLocation,
    this.backgroundUrl,
    this.backgroundLogo,
    required this.verificationStatus,
    required this.currentPlan,
    required this.followerCount,
    required this.isFollowing,
    required this.isFeatured,
    required this.categories,
    required this.id,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      businessName: json["id"],
      businessDescription: json["businessDescription"],
      businessLocation: json["businessLocation"],
      verificationStatus: json["verificationStatus"],
      currentPlan: json["currentPlan"],
      followerCount: json["followCount"],
      isFollowing: json["isFollowing"],
      isFeatured: json["isFeatured"],
      categories: List<String>.from(json['categories'] ?? []),
      id: json["id"],
    );
  }
}
