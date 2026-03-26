import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:emr_application/config.dart';
import 'package:emr_application/utils/jwt.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart'
    as flutter_zoom_view;
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';

class Videochat extends StatefulWidget {
  const Videochat({super.key});
  @override
  State<Videochat> createState() => _VideochatState();
}

class _VideochatState extends State<Videochat> {
  final zoom = ZoomVideoSdk();
  final eventListener = ZoomVideoSdkEventListener();
  bool isInSession = false;
  List<StreamSubscription> subscriptions = [];
  List<ZoomVideoSdkUser> users = [];
  bool isMuted = true;
  bool isVideoOn = false;
  bool isLoading = false;
  String debugStatus = "Waiting for initialization...";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  _handleSessionJoin(data) async {
    if (!mounted) return;
    final mySelf = ZoomVideoSdkUser.fromJson(jsonDecode(data['sessionUser']));
    _updateDebugStatus("Joined session as ${mySelf.userName}");
    final remoteUsers = await zoom.session.getRemoteUsers() ?? [];
    final isMutedState = await mySelf.audioStatus?.isMuted() ?? true;
    final isVideoOnState = await mySelf.videoStatus?.isOn() ?? false;
    setState(() {
      isInSession = true;
      isLoading = false;
      isMuted = isMutedState;
      isVideoOn = isVideoOnState;
      users = [mySelf, ...remoteUsers];
    });
  }

  _updateUserList(data) async {
    final mySelf = await zoom.session.getMySelf();
    if (mySelf == null) return;
    final remoteUserList = await zoom.session.getRemoteUsers() ?? [];
    remoteUserList.insert(0, mySelf);
    setState(() {
      users = remoteUserList;
    });
  }

  _handleVideoChange(data) async {
    if (!mounted) return;
    final mySelf = await zoom.session.getMySelf();
    final videoStatus = await mySelf?.videoStatus?.isOn() ?? false;
    setState(() {
      isVideoOn = videoStatus;
    });
  }

  _handleAudioChange(data) async {
    if (!mounted) return;
    final mySelf = await zoom.session.getMySelf();
    final audioStatus = await mySelf?.audioStatus?.isMuted() ?? true;
    setState(() {
      isMuted = audioStatus;
    });
  }

  _setupEventListeners() {
    subscriptions = [
      eventListener.addListener(EventType.onSessionJoin, _handleSessionJoin),
      eventListener.addListener(EventType.onSessionLeave, handleLeaveSession),
      eventListener.addListener(EventType.onUserJoin, _updateUserList),
      eventListener.addListener(EventType.onUserLeave, _updateUserList),
      eventListener.addListener(
          EventType.onUserVideoStatusChanged, _handleVideoChange),
      eventListener.addListener(
          EventType.onUserAudioStatusChanged, _handleAudioChange),
    ];
  }

  Future startSession() async {
    setState(() {
      isLoading = true;
      debugStatus = "Starting session...";
    });
    try {
      final token = generateJwt(
          sessionDetails['sessionName'], sessionDetails['roleType']);
      _updateDebugStatus("Token generated. Joining...");
      _setupEventListeners();
      await zoom.joinSession(JoinSessionConfig(
        sessionName: sessionDetails['sessionName']!,
        sessionPassword: sessionDetails['sessionPassword']!,
        token: token,
        userName: sessionDetails['displayName']!,
        audioOptions: {"connect": true, "mute": true},
        videoOptions: {"localVideoOn": true},
        sessionIdleTimeoutMins: int.parse(sessionDetails['sessionTimeout']!),
      ));
    } catch (e) {
      debugPrint("Error: $e");
      setState(() {
        isLoading = false;
        debugStatus = "Error: $e";
      });
    }
  }

  void _updateDebugStatus(String status) {
    if (mounted) {
      setState(() => debugStatus = status);
    }
  }

  handleLeaveSession([data]) {
    if (!mounted) return;
    setState(() {
      isInSession = false;
      isLoading = false;
      users = [];
    });
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
    zoom.leaveSession(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            if (!isInSession)
              Center(
                child: ElevatedButton(
                  onPressed: isLoading ? null : startSession,
                  child: Text(isLoading ? 'Connecting...' : 'Start Session'),
                ),
              )
            else
              Stack(
                children: [
                  VideoGrid(users: users),
                  ControlBar(
                    isMuted: isMuted,
                    isVideoOn: isVideoOn,
                    onLeaveSession: handleLeaveSession,
                    onToggleMute: () async {
                      final mySelf = await zoom.session.getMySelf();
                      if (mySelf != null) {
                        if (isMuted) {
                          zoom.audioHelper.unMuteAudio(mySelf.userId);
                        } else {
                          zoom.audioHelper.muteAudio(mySelf.userId);
                        }
                      }
                    },
                    onToggleVideo: () async {
                      if (isVideoOn) {
                        zoom.videoHelper.stopVideo();
                      } else {
                        zoom.videoHelper.startVideo();
                      }
                    },
                  ),
                ],
              ),
            // Permanent working debug overlay
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Debug: $debugStatus",
                  style:
                      const TextStyle(color: Colors.greenAccent, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoGrid extends StatelessWidget {
  final List<ZoomVideoSdkUser> users;
  const VideoGrid({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: users.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          color: Colors.black,
          child: Stack(
            children: [
              flutter_zoom_view.View(
                key: Key(users[index].userId),
                creationParams: {
                  "userId": users[index].userId,
                  "sharing": false,
                  "preview": false,
                  "focused": false,
                  "hasMultiCamera": false,
                  "isPiPView": false,
                  "videoAspect": VideoAspect.PanAndScan,
                  "fullScreen": false,
                },
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Text(
                  users[index].userName,
                  style: const TextStyle(
                      color: Colors.white, backgroundColor: Colors.black54),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ControlBar extends StatelessWidget {
  final bool isMuted;
  final bool isVideoOn;
  final VoidCallback onLeaveSession;
  final VoidCallback onToggleMute;
  final VoidCallback onToggleVideo;

  const ControlBar({
    super.key,
    required this.isMuted,
    required this.isVideoOn,
    required this.onLeaveSession,
    required this.onToggleMute,
    required this.onToggleVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon:
                Icon(isMuted ? Icons.mic_off : Icons.mic, color: Colors.white),
            onPressed: onToggleMute,
            style: IconButton.styleFrom(
                backgroundColor: isMuted ? Colors.red : Colors.green),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: Icon(isVideoOn ? Icons.videocam : Icons.videocam_off,
                color: Colors.white),
            onPressed: onToggleVideo,
            style: IconButton.styleFrom(
                backgroundColor: isVideoOn ? Colors.green : Colors.red),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.call_end, color: Colors.white),
            onPressed: onLeaveSession,
            style: IconButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
