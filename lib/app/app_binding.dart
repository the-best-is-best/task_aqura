import 'package:get/get.dart';
import 'package:task_aqura/presentation/login/controller/login_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
