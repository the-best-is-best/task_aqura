import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/login/view/login_view.dart';

class Routes {
  static const non = "/";

  static const loginRoute = "/login";
  // static const videoRoute = "/videoCall";
}

class RouteGeneratorGetX {
  static List<GetPage> getRoutes() => <GetPage>[
        GetPage(
          name: Routes.non,
          page: () => unDefinedRoute(),
        ),
        GetPage(
          name: Routes.loginRoute,
          page: () => const LoginView(),
        ),
      ];
  static Widget unDefinedRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404'),
      ),
      body: const Center(child: Text('404')),
    );
  }
}
