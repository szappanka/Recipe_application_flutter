import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayer extends StatefulWidget {
  const YoutubePlayer({Key? key, this.url = ""}) : super(key: key);

  final String url;

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  YoutubePlayerController? _ytbPlayerController;
  late String _url;

  @override
  void initState() {
    super.initState();
    _url = widget.url;
    _ytbPlayerController = YoutubePlayerController(
      initialVideoId: _url,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _ytbPlayerController = YoutubePlayerController(
          initialVideoId: _url,
          params: const YoutubePlayerParams(
            showFullscreenButton: true,
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController!.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildYtbView(),
    );
  }

  _buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _ytbPlayerController != null
          ? YoutubePlayerIFrame(controller: _ytbPlayerController)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
