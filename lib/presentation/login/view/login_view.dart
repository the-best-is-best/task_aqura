import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_aqura/presentation/login/controller/login_controller.dart';

import '../../../resources/components/imput_field.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final LoginController _loginController;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _loginController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: AppSpacing.ap100,
                left: AppSpacing.ap14,
                right: AppSpacing.ap14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Obx(() {
                    return InputField(
                        themeData: themeData,
                        label: "${AppStrings.addNumber} *",
                        keyBoardType: TextInputType.number,
                        errorText: _loginController.alertaNumberValid.value,
                        onChanged: (String? val) {
                          _loginController.setNumberEvent(val ?? "");
                        });
                  }),
                ),
                const SizedBox(
                  height: AppSpacing.ap30,
                ),
                Obx(() => _loginController.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed:
                            _loginController.alertaNumberValid.value == null &&
                                    _loginController
                                        .loginObject.value.codeNumber.isNotEmpty
                                ? () {
                                    _loginController.login();
                                  }
                                : null,
                        child: const Text("Login"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
