import 'package:get/get.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}