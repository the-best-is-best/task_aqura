import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:task_aqura/presentation/common/freezed/freezed_data.dart';
import 'package:task_aqura/presentation/video_call/view/video_call_view.dart';
import 'package:task_aqura/resources/routes_manger.dart';

import '../../../resources/strings_manager.dart';
import '../../../services/firebase_database_methods.dart';

class LoginController extends GetxController {
  void setNumberEvent(String num) {
    loginObject.value = loginObject.value.copyWith(codeNumber: num);
    isNumberValid(num);
  }

  Rxn<String?> alertaNumberValid = Rxn<String>();

  String? isNumberValid(String num) {
    if (num.isEmpty) {
      alertaNumberValid.value = AppStrings.required;
      return AppStrings.required;
    } else {
      if (num.length < 4) {
        alertaNumberValid.value = AppStrings.errorNumber;

        return AppStrings.errorNumber;
      } else {
        alertaNumberValid.value = null;

        return null;
      }
    }
  }

  Rx<LoginObject> loginObject = LoginObject("").obs;
  RxBool isLoading = RxBool(false);
  void login() async {
    isLoading.value = true;
    bool logined = await FirebaseDatabaseMethods.startLiveStream(
        loginObject.value.codeNumber);
    if (logined) {
      Get.to(VideoCallView(userNamber: loginObject.value.codeNumber));
    }
    isLoading.value = false;
  }
}
