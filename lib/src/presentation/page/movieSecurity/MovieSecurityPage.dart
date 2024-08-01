import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class MovieSecurityPage extends StatefulWidget {
  const MovieSecurityPage({Key? key}) : super(key: key);

  @override
  _MovieSecurityPageState createState() => _MovieSecurityPageState();
}

class _MovieSecurityPageState extends State<MovieSecurityPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  late CachedVideoPlayerController _videoPlayerController;

  final String assetVideoPath = "assets/movie/usodecinturondeseguridadvehiculoindra.mp4";

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void initializeVideoPlayer() {
    _videoPlayerController = CachedVideoPlayerController.asset(assetVideoPath)
      ..initialize().then((_) {
        setState(() {
          _customVideoPlayerController = CustomVideoPlayerController(
            context: context,
            videoPlayerController: _videoPlayerController,
          );
        });
      }).catchError((e) {
        print('Error de video ${e.toString()}');
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            _videoPlayerController.value.isInitialized
                ? CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            )
                : Center(child: CircularProgressIndicator()),
            SizedBox(height: 16),
            Text(
              "Uso de Cinturón de Seguridad en Vehículo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
