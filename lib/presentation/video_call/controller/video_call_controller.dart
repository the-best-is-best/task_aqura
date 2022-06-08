import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../services/agora_settings.dart';
import '../../../services/firebase_database_methods.dart';

class VideoCallController extends GetxController {
  String channelName = AgoraSettings.channelName;
  late final String userNumber;
  RxList<String> infoString = <String>[].obs;
  final ClientRole role = ClientRole.Broadcaster;
  void setUserNumber(String sendUserNumber) {
    userNumber = sendUserNumber;
  }

  final RxList<int> users = RxList<int>();
  RxBool mute = false.obs;
  RxBool viewPanel = false.obs;
  late RtcEngine rtcEngine;

  @override
  void onInit() async {
    await _handlePermission(Permission.camera);
    await _handlePermission(Permission.microphone);

    super.onInit();
  }

  @override
  void onReady() {
    _initializeEngine();
    super.onReady();
  }

  void _initializeEngine() async {
    rtcEngine = await RtcEngine.create(AgoraSettings.appId);
    await rtcEngine.enableVideo();

    await rtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await rtcEngine.setClientRole(role);
    addEventAgoraHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 1920, height: 1080));
    await rtcEngine.setVideoEncoderConfiguration(configuration);
    await rtcEngine.joinChannel(AgoraSettings.token, channelName, null, 0);
  }

  void addEventAgoraHandlers() {
    rtcEngine.setEventHandler(RtcEngineEventHandler(error: (code) {
      final String info = 'error: $code';
      infoString.add(info);
      FirebaseDatabaseMethods.addInfoRoom(infoString, userNumber);
    }, joinChannelSuccess: (channel, uid, elapsed) {
      final String info = 'join channel: $channel , uid $uid';
      infoString.add(info);
      users.add(uid);
      FirebaseDatabaseMethods.addInfoRoom(infoString, userNumber);
    }, leaveChannel: (state) {
      infoString.add('leave channel');
      users.clear();
      FirebaseDatabaseMethods.removeInfoRoom(userNumber);
    }, userJoined: (uid, elapsed) {
      final String info = 'user joined $uid';
      infoString.add(info);
      users.add(uid);
      FirebaseDatabaseMethods.addInfoRoom(infoString, userNumber);
    }, userOffline: (uid, elabsed) {
      final info = 'User offline: $uid';
      infoString.add(info);
      users.remove(uid);
    }, firstRemoteVideoFrame: (uid, width, height, elasbsed) {
      final String info = 'First Remote Video : $uid ${width}x $height';
      infoString.add(info);
      FirebaseDatabaseMethods.addInfoRoom(infoString, userNumber);
    }));
  }

  @override
  void onClose() async {
    await FirebaseDatabaseMethods.endLiveStream(userNumber);

    users.clear();
    rtcEngine.leaveChannel();
    rtcEngine.destroy();
    super.onClose();
  }

  Future _handlePermission(Permission permission) async {
    await permission.request();
  }
}
