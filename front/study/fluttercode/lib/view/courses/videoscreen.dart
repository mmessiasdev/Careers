import 'package:Consult/component/colors.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({super.key, required this.id, required this.urlbanner});
  final String id;
  final String urlbanner;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  var token;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    setState(() {
      token = strToken.toString();
    });
  }

  void initializeYoutubePlayer(String videoUrl) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: token == "null"
            ? const SizedBox()
            : FutureBuilder<Map>(
                future: RemoteAuthService()
                    .getOneVideo(token: token, id: widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: SubText(
                        text: 'Erro ao carregar vídeo',
                        color: PrimaryColor,
                        align: TextAlign.center,
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    var render = snapshot.data!;
                    initializeYoutubePlayer(
                        render["url"]);

                    return Padding(
                      padding: defaultPaddingHorizon,
                      child: ListView(
                        children: [
                          MainHeader(
                            maxl: 4,
                            title: "NIDE",
                            icon: Icons.arrow_back_ios,
                            onClick: () {
                              Navigator.pop(context);
                            },
                          ),
                          if (_youtubeController != null)
                            Padding(
                              padding: defaultPaddingVertical,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: YoutubePlayer(
                                  controller: _youtubeController!,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: PrimaryColor,
                                ),
                              ),
                            ),
                          SecundaryText(
                            text: render["name"],
                            color: nightColor,
                            align: TextAlign.center,
                          ),
                          const SizedBox(height: 35),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubText(
                                      color: nightColor,
                                      text:
                                          "Tempo do vídeo: ${render["time"].toString()} horas",
                                      align: TextAlign.start,
                                    ),
                                    const SizedBox(height: 10),
                                    SubText(
                                      color: nightColor,
                                      text: "Descrição: ${render["desc"]}",
                                      align: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const Divider(),
                          const SizedBox(height: 25),
                        ],
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
      ),
    );
  }
}
