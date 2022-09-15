import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatefulWidget {
  final String url;
  PlayVideoPage({Key? key, required this.url}) : super(key: key);

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(widget.url),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context: context,),
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            children: [
              FlickVideoPlayer(
                  flickManager: flickManager,
                // preferredDeviceOrientation: [DeviceOrientation.landscapeRight,DeviceOrientation.portraitUp],
              ),
              Positioned(
                top: 16, left: 16,
                child: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: (){
                  Navigator.pop(context);
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}