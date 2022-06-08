import 'package:flutter/material.dart';

const String _imagePath = "assets/images";
const String _jsonPath = "assets/json";

Widget getAssetsImage(String path) {
  return Image(image: AssetImage(path));
}

class ImageAssets {
  static const String logoInLight = "$_imagePath/logo_in_light.png";
  static const String onBoarding1 = "$_imagePath/onboard1.svg";
  static const String onBoarding2 = "$_imagePath/onboard2.svg";
  static const String onBoarding3 = "$_imagePath/onboard3.svg";
}

class JsonAssets {
  static const String loading = "$_jsonPath/loading.json";
  static const String error = "$_jsonPath/error.json";
  static const String empty = "$_jsonPath/empty.json";
  static const String checkEmail = "$_jsonPath/check_email.json";
  static const String success = "$_jsonPath/success.json";
  static const String networkError = "$_jsonPath/connection_error.json";
}
