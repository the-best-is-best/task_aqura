import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_aqura/app/app_binding.dart';

import '../resources/routes_manger.dart';
import '../resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeDataLight,
      initialBinding: AppBinding(),
      getPages: RouteGeneratorGetX.getRoutes(),
      initialRoute: Routes.loginRoute,
    );
  }
}
