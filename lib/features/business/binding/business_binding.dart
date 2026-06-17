import 'package:get/get.dart';
import 'package:nirvana_mobile/features/business/controller/business_controller.dart';

class BusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessController>(() => BusinessController());
  }
}
