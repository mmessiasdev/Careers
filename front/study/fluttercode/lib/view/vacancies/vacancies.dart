import 'package:Consult/component/buttons.dart';
import 'package:Consult/component/colors.dart';
import 'package:Consult/component/containersLoading.dart';
import 'package:Consult/component/coursecontent.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/component/widgets/vacanciecont.dart';
import 'package:Consult/model/vacancies.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:Consult/view/courses/examsscreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VacanciesScreen extends StatefulWidget {
  const VacanciesScreen({super.key});

  @override
  State<VacanciesScreen> createState() => _VacanciesScreenState();
}

class _VacanciesScreenState extends State<VacanciesScreen> {
  var token;
  var profileId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strProfileId = await LocalAuthService().getId("id");

    setState(() {
      token = strToken.toString();
      profileId = strProfileId.toString();
    });
  }

  // Função para formatar a data no padrão brasileiro
  String _formatDate(String updatedAt) {
    // Converte a string para DateTime
    DateTime date = DateTime.parse(updatedAt);
    // Formata a data no padrão brasileiro (dd/MM/yyyy)
    return DateFormat('dd/MM/yyyy').format(date);
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
                  title: "Vagas de emprego",
                  maxl: 2,
                )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FutureBuilder<List<Vacancies>>(
                  future: RemoteAuthService().getVacancies(token: token),
                  builder: (context, planSnapshot) {
                    if (planSnapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: planSnapshot.data!.length,
                          itemBuilder: (context, index) {
                            var renders = planSnapshot.data![index];
                            if (renders != null) {
                              return Padding(
                                padding: defaultPaddingHorizon,
                                child: VacancieCont(
                                  urlLogo: renders.urlLogo,
                                  subtitle: _formatDate(renders.updatedAt
                                      .toString()), // Formatar a data aqui
                                  title: renders.title.toString(),
                                  id: renders.id.toString(),
                                ),
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
          ],
        ),
      ),
    );
  }
}
