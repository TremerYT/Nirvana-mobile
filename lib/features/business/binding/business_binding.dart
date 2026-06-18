import 'package:get/get.dart';
import 'package:nirvana_mobile/features/business/controller/business_controller.dart';
import 'package:nirvana_mobile/features/profile/controller/profile_controller.dart';

class BusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessController>(() => BusinessController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
