import 'package:Consult/component/buttons.dart';
import 'package:Consult/component/categorie.dart';
import 'package:Consult/component/containersLoading.dart';
import 'package:Consult/component/coursecontent.dart';
import 'package:Consult/component/inputdefault.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/component/widgets/iconlist.dart';
import 'package:Consult/component/widgets/searchInput.dart';
import 'package:Consult/controller/auth.dart';
import 'package:Consult/model/categories.dart';
import 'package:Consult/model/courses.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:Consult/view/account/account.dart';
import 'package:Consult/view/courses/addcourse.dart';
import 'package:Consult/view/courses/ourcourses.dart';
import 'package:Consult/view/indicators/indicatorsreen.dart';
import 'package:Consult/view/profiles/employeescreen.dart';
import 'package:flutter/material.dart';
import 'package:Consult/component/colors.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var client = http.Client();

  String screen = "online";
  bool isButtonEnabled = false;

  String? fname;
  String? fullname;
  String? colaboratorId;

  bool teacher = false;

  var id;
  bool public = false;

  var token;
  var idInterprise;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strfullname = await LocalAuthService().getFullName("fullname");

    var strIdInterprise =
        await LocalAuthService().getIdInterprise("idInterprise");

    if (mounted) {
      setState(() {
        token = strToken.toString();
        fullname = strfullname;

        idInterprise = strIdInterprise.toString();
      });
    }
  }

  TextEditingController cpf = TextEditingController();

  Widget ManutentionErro() {
    return ErrorPost(
      text: "Estamos passando por uma manutenção. Entre novamente mais tarde!",
    );
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
                      Container(
                        decoration: BoxDecoration(
                            color: SecudaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            (
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountScreen(
                                    buttom: true,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: defaultPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SubText(
                                      text: 'Meu Perfil',
                                      align: TextAlign.start,
                                      color: nightColor,
                                    ),
                                    SubTextSized(
                                      text:
                                          'Verificar informações e sair da conta',
                                      size: 10,
                                      fontweight: FontWeight.w600,
                                      color: OffColor,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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
        ? const SizedBox()
        : SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: defaultPaddingHorizon,
                  child: MainHeader(
                    title: "NIDE",
                    icon: Icons.menu,
                    maxl: 2,
                    onClick: () => _showDraggableScrollableSheet(context),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: defaultPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: IconList(
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OurCourses(),
                                    ),
                                  );
                                },
                                icon: Icons.favorite,
                                title: "Minhas Playlsits"),
                          ),
                          IconList(
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmployeeScreen(),
                                  ),
                                );
                              },
                              icon: Icons.flash_on,
                              title: "Promoções Relâmpagos"),
                          IconList(
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndicatorsScreen(),
                                ),
                              );
                            },
                            icon: Icons.movie,
                            title: "Meus Cursos",
                          ),
                          IconList(
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndicatorsScreen(),
                                ),
                              );
                            },
                            icon: Icons.edit_document,
                            title: "Meus Certificados",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: defaultPaddingHorizon,
                      child: SearchInput(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    teacher == true
                        ? Padding(
                            padding: defaultPaddingHorizon,
                            child: GestureDetector(
                              onTap: () {
                                (
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddCourseScreen()),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: PrimaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: defaultPadding,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add),
                                      SubText(
                                          text: "Adicionar Curso",
                                          align: TextAlign.start)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: SecudaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: defaultPadding,
                            child: SecundaryText(
                                text: 'Cursos feitos para você',
                                color: nightColor,
                                align: TextAlign.start),
                          ),
                          FutureBuilder<List<CoursesModel>>(
                            future: RemoteAuthService().getCourses(
                                token: token, interpriseId: idInterprise),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                        "Nenhum curso disponível no momento."),
                                  );
                                } else {
                                  return ListView.builder(
                                    // gridDelegate:
                                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                                    //   crossAxisCount: 1,
                                    //   crossAxisSpacing: 1,
                                    //   mainAxisSpacing: 1,
                                    //   childAspectRatio: 0.75, // Proporção padrão
                                    // ),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      var renders = snapshot.data![index];
                                      return CourseContent(
                                        urlThumb: renders.urlbanner.toString(),
                                        subtitle: "${renders.desc}",
                                        title: renders.title.toString(),
                                        id: renders.id.toString(),
                                        price: renders.price == ""
                                            ? "Grátis"
                                            : "${renders.price.toString()}R\$",
                                        time:
                                            "Tempo médio do curso: ${renders.time} horas",
                                      );
                                    },
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return WidgetLoading();
                              }
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: nightColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: defaultPadding,
                            child: SecundaryText(
                                text: 'Categorías',
                                color: nightColor,
                                align: TextAlign.start),
                          ),
                          FutureBuilder<List<CategoryModel>>(
                            future:
                                RemoteAuthService().getCategories(token: token),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                        "Nenhum curso disponível no momento."),
                                  );
                                } else {
                                  return SizedBox(
                                    height: 280,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        var renders = snapshot.data![index];
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Categorie(
                                              title: renders.name.toString(),
                                              id: renders.id.toString(),
                                              illurl: renders.banner.toString(),
                                            ));
                                      },
                                    ),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return WidgetLoading();
                              }
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: nightColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(),
              ],
            ),
          );
  }
}
