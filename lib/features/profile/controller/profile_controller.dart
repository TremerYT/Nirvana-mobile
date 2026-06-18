import 'package:get/get.dart';
import 'package:nirvana_mobile/core/services/user_service.dart';
import 'package:nirvana_mobile/features/profile/models/user_model.dart';

class ProfileController extends GetxController {
  final _userService = UserService();
  var currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }

  Future<void> loadCurrentUser() async {
    try {
      currentUser.value = await _userService.getCurrentUser();
    } catch (e) {
      //
    }
  }
}
