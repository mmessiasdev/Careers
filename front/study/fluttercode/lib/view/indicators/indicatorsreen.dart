import 'package:Consult/component/colaboratorcontent.dart';
import 'package:Consult/component/colors.dart';
import 'package:Consult/component/coursecontent.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/model/courses.dart';
import 'package:Consult/model/profiles.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IndicatorsScreen extends StatefulWidget {
  const IndicatorsScreen({super.key});

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  var token;
  var idInterprise;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strIdInterprise =
        await LocalAuthService().getIdInterprise("idInterprise");

    setState(() {
      token = strToken.toString();
      idInterprise = strIdInterprise.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: Padding(
          padding: defaultPaddingHorizon,
          child: ListView(
            children: [
              MainHeader(
                  title: "Indicadores",
                  maxl: 1,
                  icon: Icons.arrow_back_ios,
                  onClick: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                height: 20,
              ),
              Center(
                child: FutureBuilder<List<ProfilesModel>>(
                    future: RemoteAuthService().getEnterpriseProfiles(
                        token: token, id: idInterprise.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              var renders = snapshot.data![index];
                              if (renders != null) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SubText(
                                        text: "Colaboradores:",
                                        align: TextAlign.start),
                                    RichDefaultText(
                                      text: "Estudantes:",
                                      wid: SubText(
                                          text:
                                              snapshot.data!.length.toString(),
                                          align: TextAlign.start),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text('Não encontrado'),
                                ),
                              );
                            });
                      }
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: nightColor,
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: FutureBuilder<List<CoursesModel>>(
                    future: RemoteAuthService().getCourses(
                        token: token, interpriseId: idInterprise.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              var renders = snapshot.data![index];
                              if (renders != null) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SubText(
                                        text: "Cursos:",
                                        align: TextAlign.start),
                                    RichDefaultText(
                                      text: "Publicados:",
                                      wid: SubText(
                                          text:
                                              snapshot.data!.length.toString(),
                                          align: TextAlign.start),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text('Não encontrado'),
                                ),
                              );
                            });
                      }
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: nightColor,
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              SecundaryText(
                  text: "Cursos em destaque",
                  color: nightColor,
                  align: TextAlign.center),
              SizedBox(
                height: 25,
              ),
              Center(
                child: FutureBuilder<List<CoursesModel>>(
                    future: RemoteAuthService().getCourses(
                        token: token, interpriseId: idInterprise.toString()),
                    builder: (context, planSnapshot) {
                      if (planSnapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              var renders = planSnapshot.data![index];
                              if (renders != null) {
                                return CourseContent(
                                  urlLogo: renders.urlbanner.toString(),
                                  subtitle: "${renders.desc}",
                                  title: renders.time.toString(),
                                  id: renders.id.toString(),
                                );
                              }
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text('Plano não encontrado'),
                                ),
                              );
                            });
                      }
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: nightColor,
                          ),
                        ),
                      );
                    }),
              ),
              // SizedBox(
              //   height: 50,
              // ),
              // SecundaryText(
              //     text: "Cursos em destaque",
              //     color: nightColor,
              //     align: TextAlign.center),
              // SizedBox(
              //   height: 25,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
