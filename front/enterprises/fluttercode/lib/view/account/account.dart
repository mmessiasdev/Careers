import 'package:Consult/component/buttons.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/infotext.dart';
import 'package:Consult/component/widgets/title.dart';
import 'package:Consult/model/profiles.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:Consult/view/courses/addcourse.dart';
import 'package:flutter/material.dart';
import 'package:Consult/controller/controllers.dart';

import '../../component/defaultTitleButtom.dart';
import '../../component/colors.dart';
import '../../model/courses.dart';
import 'auth/signin.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key, required this.buttom}) : super(key: key);
  bool buttom;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var email;
  var fullname;
  var cpf;
  var id;
  var token;
  var idInterprise;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strEmail = await LocalAuthService().getEmail("email");
    var strFullname = await LocalAuthService().getFullName("fullname");
    var strId = await LocalAuthService().getId("id");
    var strToken = await LocalAuthService().getSecureToken("token");
    var strIdInterprise =
        await LocalAuthService().getIdInterprise("idInterprise");

    if (mounted) {
      setState(() {
        email = strEmail.toString();
        fullname = strFullname.toString();
        id = strId.toString();
        idInterprise = strIdInterprise.toString();

        token = strToken.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightColor,
      child: ListView(
        children: [
          Padding(
            padding: defaultPadding,
            child: DefaultTitle(
              buttom: widget.buttom,
              title: "Empresa",
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: PrimaryColor,
            ),
            child: Padding(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SecundaryText(
                      text: fullname == null ? "" : fullname,
                      color: lightColor,
                      align: TextAlign.start),
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
                                itemCount: snapshot.data!.length == 0
                                    ? snapshot.data!.length
                                    : 1,
                                itemBuilder: (context, index) {
                                  var renders = snapshot.data![index];
                                  if (renders != null) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        RichDefaultText(
                                          text: "Número de colaboradores:",
                                          wid: SubText(
                                              text: snapshot.data!.length
                                                  .toString(),
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
                    height: 20,
                  ),
                  Center(
                    child: FutureBuilder<List<CoursesModel>>(
                        future: RemoteAuthService().getCourses(
                            token: token,
                            interpriseId: idInterprise.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length == 0
                                    ? snapshot.data!.length
                                    : 1,
                                itemBuilder: (context, index) {
                                  var renders = snapshot.data![index];
                                  if (renders != null) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        RichDefaultText(
                                          text: "Número de cursos:",
                                          wid: SubText(
                                              text: snapshot.data!.length
                                                  .toString(),
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
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                    text: "Criar Vaga",
                    color: SeventhColor,
                    padding: defaultPadding,
                    colorText: lightColor,
                  ),
                  // InfoText(title: "Username:", stitle: cpf == "null" ? "" : cpf),
                  SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      (
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCourseScreen()),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: SecudaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: defaultPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SubText(
                                text: "Adicionar Curso", align: TextAlign.start)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  DefaultTitleButton(
                    title:
                        email == "null" ? "Entrar na conta" : "Sair da conta",
                    onClick: () {
                      if (token != "null") {
                        authController.signOut();
                        // Navigator.pop(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const SignInScreen(),
                        //   ),
                        // );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      }
                    },
                    color: FifthColor,
                    iconColor: lightColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
