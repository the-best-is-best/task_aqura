import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:task_aqura/resources/routes_manger.dart';
import 'package:task_aqura/services/firebase_database_methods.dart';
import '../controller/video_call_controller.dart';

class VideoCallView extends StatefulWidget {
  final String userNamber;
  const VideoCallView({required this.userNamber, Key? key}) : super(key: key);

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView>
    with WidgetsBindingObserver {
  final VideoCallController videoController = Get.put(VideoCallController());
  late AppLifecycleState state;

  @override
  void initState() {
    videoController.setUserNumber(widget.userNamber);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        FirebaseDatabaseMethods.endLiveStream(widget.userNamber);
        Get.back();
        break;
      case AppLifecycleState.paused:
        FirebaseDatabaseMethods.endLiveStream(widget.userNamber);
        Get.back();
        break;
      case AppLifecycleState.detached:
        FirebaseDatabaseMethods.endLiveStream(widget.userNamber);
        Get.back();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FirebaseDatabaseMethods.endLiveStream(widget.userNamber);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Agora tut"),
            actions: [
              IconButton(
                  onPressed: () {
                    videoController.viewPanel.value =
                        !videoController.viewPanel.value;
                  },
                  icon: const Icon(Icons.info_outline))
            ],
          ),
          body: Center(
            child: Obx(
              () => videoController.users.isEmpty
                  ? const Center()
                  : Stack(
                      children: [
                        _viewRoms(),
                        _panel(),
                        _toolBar(),
                        _userName(),
                      ],
                    ),
            ),
          )),
    );
  }

  Widget _userName() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "Your name is ${videoController.userNumber} ",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _toolBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              videoController.mute.value = !videoController.mute.value;
              videoController.rtcEngine
                  .muteLocalAudioStream(videoController.mute.value);
            },
            shape: const CircleBorder(),
            fillColor:
                videoController.mute.value ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
            child: Builder(builder: (_) {
              final bool mute = videoController.mute.value;

              return Icon(
                mute ? Icons.mic_off : Icons.mic,
                color: mute ? Colors.white : Colors.blueAccent,
                size: 20,
              );
            }),
          ),
          RawMaterialButton(
            onPressed: () {
              Get.offNamed(Routes.loginRoute);
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.redAccent,
            child: const Icon(
              Icons.call_end,
              size: 35,
              color: Colors.white,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              videoController.rtcEngine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.white,
            child: const Icon(
              Icons.switch_camera,
              size: 35,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel() {
    return Visibility(
      visible: videoController.viewPanel.value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: FractionallySizedBox(
          heightFactor: .5,
          child: Container(
            padding: const EdgeInsets.symmetric(),
            child: ListView.builder(
              reverse: true,
              itemCount: videoController.infoString.length,
              itemBuilder: (BuildContext context, int index) {
                final List<String?> info = videoController.infoString;
                if (info.isEmpty) {
                  return const Text('null');
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          info[index] ?? "",
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ))
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewRoms() {
    final List<dynamic> list = [];
    if (videoController.role == ClientRole.Broadcaster) {
      list.add(const rtc_local_view.SurfaceView());
    }
    for (int? uid in videoController.users) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid!,
        channelId: videoController.channelName,
      ));
    }
    return Column(
      children: List.generate(
        list.length,
        (index) => Expanded(child: list[index]),
      ),
    );
  }
}
