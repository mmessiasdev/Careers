import 'package:Consult/component/buttons.dart';
import 'package:Consult/component/colors.dart';
import 'package:Consult/component/coursecontent.dart';
import 'package:Consult/component/inputdefault.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/model/courses.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:Consult/view/account/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

  TextEditingController descCurr = TextEditingController();

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

  void _showDraggableScrollableSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
                color: Colors.white,
                child: Padding(
                  padding: defaultPadding,
                  child: ListView(
                    children: [
                      MainHeader(title: "Editar"),
                      SizedBox(
                        height: 35,
                      ),
                      SubText(
                          text: "Mudar descrição pessoal",
                          align: TextAlign.start),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: SecudaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: InputTextField(
                          title: "",
                          textEditingController: descCurr,
                          maxLines: 4,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            CurriculumScreen();
                          });
                          EasyLoading.showSuccess("Currículo Atualizado ");
                          RemoteAuthService().putProfileCurriculumDesc(
                              token: token,
                              id: profileId,
                              curriculumdesc: descCurr.text);
                        },
                        child: DefaultButton(
                          text: "Atualizar dados",
                          icon: Icons.save,
                          padding: defaultPadding,
                          color: SeventhColor,
                          colorText: lightColor,
                        ),
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return token == null
        ? SizedBox()
        : SafeArea(
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
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Cor e opacidade da sombra
                              spreadRadius: 2, // Expansão da sombra
                              blurRadius: 15, // Desfoque
                              offset: Offset(
                                  0, 3), // Deslocamento (horizontal, vertical)
                            ),
                          ],
                          color: SixthColor,
                          borderRadius: BorderRadius.circular(20)),
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
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SecundaryText(
                                                color: nightColor,
                                                text: render['curriculumdesc'],
                                                align: TextAlign.justify),
                                            GestureDetector(
                                              onTap: () {
                                                _showDraggableScrollableSheet(
                                                    context);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SubText(
                                                      text: "Editar",
                                                      align: TextAlign.end),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: PrimaryColor,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: SizedBox(
                                                        child: Icon(Icons.edit),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                  future: RemoteAuthService()
                                      .getCerfiticatesCourses(
                                          token: token,
                                          profileId: profileId.toString()),
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
                                              itemCount:
                                                  planSnapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                var renders =
                                                    planSnapshot.data![index];
                                                if (renders != null) {
                                                  return Padding(
                                                    padding:
                                                        defaultPaddingHorizon,
                                                    child: CourseContent(
                                                      urlThumb: renders
                                                          .urlbanner
                                                          .toString(),
                                                      subtitle:
                                                          "${renders.desc}",
                                                      title: renders.title
                                                          .toString(),
                                                      id: renders.id.toString(),
                                                    ),
                                                  );
                                                }
                                                return const SizedBox(
                                                  height: 100,
                                                  child: Center(
                                                    child: Text(
                                                        'Plano não encontrado'),
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
