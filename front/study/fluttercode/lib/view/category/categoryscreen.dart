import 'package:Consult/component/colors.dart';
import 'package:Consult/component/containersLoading.dart';
import 'package:Consult/component/contentproduct.dart';
import 'package:Consult/component/coursecontent.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/component/widgets/searchInput.dart';
import 'package:Consult/model/courses.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';

import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key, required this.id});
  var id;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  var token;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: token == "null"
            ? SizedBox()
            : SafeArea(
                child: Scaffold(
                    body: Column(
                  children: [
                    FutureBuilder<Map>(
                        future: RemoteAuthService()
                            .getOneCategory(token: token, id: widget.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var render = snapshot.data!;
                            return SizedBox(
                              child: Padding(
                                padding: defaultPadding,
                                child: Column(
                                  children: [
                                    MainHeader(
                                        title: render["name"],
                                        icon: Icons.arrow_back_ios,
                                        onClick: () {
                                          (Navigator.pop(context));
                                        }),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        child: Image.network(
                                          render['banner'],
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Expanded(
                              child: Center(
                                  child: SubText(
                                text: 'Erro ao pesquisar Categoria',
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
                    Expanded(
                      child: FutureBuilder<List<CoursesModel>>(
                        future: RemoteAuthService()
                            .getOneCategoryCourse(token: token, id: widget.id),
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
                              itemBuilder: (context, index) {
                                var renders = snapshot.data![index];
                                if (renders != null) {
                                  return CourseContent(
                                    urlLogo: renders.urlbanner.toString(),
                                    subtitle: "${renders.desc}",
                                    title: renders.title.toString(),
                                    id: renders.id.toString(),
                                    price: renders.price == ""
                                        ? "Grátis"
                                        : "${renders.price.toString()}R\$",
                                    time:
                                        "Tempo médio do curso: ${renders.time} horas",
                                  );
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
                )),
              ),
      ),
    );
  }
}
