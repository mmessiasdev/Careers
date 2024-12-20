import 'package:Consult/component/buttons.dart';
import 'package:Consult/component/colors.dart';
import 'package:Consult/component/containersLoading.dart';
import 'package:Consult/component/coursecontent.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/tips.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/component/widgets/searchInput.dart';
import 'package:Consult/model/courses.dart';
import 'package:Consult/model/video.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  CourseScreen({super.key, required this.id});
  String id;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  var client = http.Client();
  var email;
  var lname;
  var token;
  var id;
  var chunkId;
  var fileBytes;
  var fileName;

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

  // Função para abrir o link
  Future<void> _launchURL(urlAff) async {
    if (!await launchUrl(urlAff, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlAff';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: token == "null"
            ? const SizedBox()
            : ListView(
                children: [
                  FutureBuilder<Map>(
                      future: RemoteAuthService()
                          .getOneCourse(token: token, id: widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var render = snapshot.data!;

                          return SizedBox(
                            child: Padding(
                              padding: defaultPaddingHorizon,
                              child: Column(
                                children: [
                                  MainHeader(
                                      maxl: 4,
                                      title: "NIDE",
                                      icon: Icons.arrow_back_ios,
                                      onClick: () {
                                        (Navigator.pop(context));
                                      }),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: SizedBox(
                                          child: Image.network(
                                              render["urlbanner"])),
                                    ),
                                  ),
                                  SecundaryText(
                                      text: render["title"],
                                      color: nightColor,
                                      align: TextAlign.center),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.favorite,
                                            size: 35,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SubText(
                                              color: nightColor,
                                              text:
                                                  "Tempo do curso: ${render["time"]} horas",
                                              align: TextAlign.end,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SubText(
                                              color: nightColor,
                                              text: "Nível: ${render["nivel"]}",
                                              align: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: defaultPaddingVertical,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: DefaultButton(
                                        text: "Comprar",
                                        color: SeventhColor,
                                        padding: defaultPadding,
                                        colorText: lightColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.card_giftcard),
                                      SubTextSized(
                                          text: render["price"] ?? "Grátis",
                                          size: 26,
                                          align: TextAlign.end,
                                          fontweight: FontWeight.w600),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Expanded(
                            child: Center(
                                child: SubText(
                              text: 'Erro ao pesquisar Store',
                              color: PrimaryColor,
                              align: TextAlign.center,
                            )),
                          );
                        }
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: PrimaryColor,
                            ),
                          ),
                        );
                      }),
                  SecundaryText(
                      text: "Vídeos do Curso",
                      color: nightColor,
                      align: TextAlign.start),
                  SizedBox(
                    height: 400,
                    child: FutureBuilder<List<Videos>>(
                      future: RemoteAuthService().getOneCourseVideos(
                          token: token, id: widget.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            // gridDelegate:
                            //     const SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            //   crossAxisSpacing: 1,
                            //   mainAxisSpacing: 1,
                            //   childAspectRatio: 0.75, // Proporção padrão
                            // ),
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var renders = snapshot.data![index];
                              if (renders != null) {
                                return CourseContent(
                                    title: renders.name.toString(),
                                    id: renders.id.toString());
                              }
                              return SizedBox(
                                  height: 300,
                                  child: ErrorPost(
                                      text:
                                          'Não encontrado. \n\nVerifique sua conexão, por gentileza.'));
                            },
                          );
                        }
                        return SizedBox(
                            height: 300,
                            child: ErrorPost(text: 'Carregando...'));
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
