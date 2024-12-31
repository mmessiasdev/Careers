import 'package:Consult/component/colors.dart';
import 'package:Consult/component/coursecontent.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/model/courses.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:flutter/material.dart';

class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  var token;
  var profileId;
  var email;
  var fullname;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strProfileId = await LocalAuthService().getId("id");

    var strEmail = await LocalAuthService().getEmail("email");
    var strFullname = await LocalAuthService().getFullName("fullname");

    setState(() {
      email = strEmail.toString();
      fullname = strFullname.toString();
      token = strToken.toString();
      profileId = strProfileId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: ListView(
          children: [
            Padding(
              padding: defaultPaddingHorizon,
              child: MainHeader(
                  title: "Currículo",
                  maxl: 1,
                  icon: Icons.arrow_back_ios,
                  onClick: () {
                    Navigator.pop(context);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: defaultPadding,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Cor e opacidade da sombra
                    spreadRadius: 2, // Expansão da sombra
                    blurRadius: 15, // Desfoque
                    offset: Offset(0, 3), // Deslocamento (horizontal, vertical)
                  ),
                ], color: SixthColor, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SecundaryText(
                              text: fullname,
                              color: nightColor,
                              align: TextAlign.end),
                          SizedBox(
                            height: 5,
                          ),
                          SubText(text: email, align: TextAlign.end),
                          SizedBox(
                            height: 45,
                          ),
                          FutureBuilder<Map>(
                              future: RemoteAuthService()
                                  .getProfileDetails(token: token),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var render = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SubText(
                                          text:
                                              "Data de nasimento: ${render['birth']}",
                                          align: TextAlign.start),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SecundaryText(
                                          color: nightColor,
                                          text: render['curriculumdesc'],
                                          align: TextAlign.justify),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Expanded(
                                    child: Center(
                                        child: SubText(
                                      text: 'Erro ao pesquisar Currículo',
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
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Divider(),
                      Center(
                        child: FutureBuilder<List<CoursesModel>>(
                            future: RemoteAuthService().getCerfiticatesCourses(
                                token: token, profileId: profileId.toString()),
                            builder: (context, planSnapshot) {
                              if (planSnapshot.hasData) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SecundaryText(
                                        text: "Grade de capacitações",
                                        color: nightColor,
                                        align: TextAlign.start),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: planSnapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          var renders =
                                              planSnapshot.data![index];
                                          if (renders != null) {
                                            return Padding(
                                              padding: defaultPaddingHorizon,
                                              child: CourseContent(
                                                urlThumb: renders.urlbanner
                                                    .toString(),
                                                subtitle: "${renders.desc}",
                                                title: renders.title.toString(),
                                                id: renders.id.toString(),
                                              ),
                                            );
                                          }
                                          return const SizedBox(
                                            height: 100,
                                            child: Center(
                                              child:
                                                  Text('Plano não encontrado'),
                                            ),
                                          );
                                        }),
                                  ],
                                );
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
