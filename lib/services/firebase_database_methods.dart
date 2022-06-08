import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_aqura/presentation/login/controller/login_controller.dart';

import '../domain/models/livestream.dart';
import 'agora_settings.dart';

class FirebaseDatabaseMethods {
  static final DatabaseReference _firestore = FirebaseDatabase.instance.ref();

  static Future<bool> startLiveStream(String userNumber) async {
    try {
      if (userNumber.isNotEmpty && userNumber.length == 4) {
        print("userNumber ::: $userNumber");

        if (!((await _firestore
                .child('livestream')
                .child(AgoraSettings.channelName)
                .child(userNumber)
                .get())
            .exists)) {
          LiveStream liveStream = LiveStream(
            userId: int.parse(userNumber),
            numberCode: userNumber,
            channelName: AgoraSettings.channelName,
          );

          _firestore
              .child('livestream')
              .child(AgoraSettings.channelName)
              .child(userNumber)
              .set(liveStream.toMap());

          return true;
        } else {
          Get.showSnackbar(const GetSnackBar(
              message: 'Two Livestreams cannot start at the same time.',
              duration: Duration(seconds: 2)));
        }
        return false;
      } else {
        Get.showSnackbar(const GetSnackBar(
            message: 'Please enter all the fields',
            duration: Duration(seconds: 2)));
        return false;
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message!,
        duration: const Duration(seconds: 2),
      ));
      return false;
    }
  }

  static Future<void> addInfoRoom(
      List<String> infoString, String userNumber) async {
    String jsonInfo = jsonEncode(infoString);
    Map<String, Object> value = {'info': jsonInfo};
    _firestore
        .child('livestream')
        .child(AgoraSettings.channelName)
        .child(userNumber)
        .update(value);
  }

  static Future<void> removeInfoRoom(String userNumber) async {
    _firestore
        .child('livestream')
        .child(AgoraSettings.channelName)
        .child(userNumber)
        .remove();
  }

  static Future<void> endLiveStream(String userNumber) async {
    try {
      await _firestore
          .child('livestream')
          .child(AgoraSettings.channelName)
          .child(userNumber)
          .remove();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
