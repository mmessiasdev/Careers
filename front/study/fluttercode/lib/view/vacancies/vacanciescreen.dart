import 'package:Consult/component/buttons.dart';
import 'package:Consult/component/colors.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VacancieScreen extends StatefulWidget {
  VacancieScreen({super.key, required this.id});
  final String id;

  @override
  State<VacancieScreen> createState() => _VacancieScreenState();
}

class _VacancieScreenState extends State<VacancieScreen> {
  var id;
  var token;
  var idInterprise;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strId = await LocalAuthService().getId("id");
    var strToken = await LocalAuthService().getSecureToken("token");
    var strIdInterprise =
        await LocalAuthService().getIdInterprise("idInterprise");

    if (mounted) {
      setState(() {
        id = strId.toString();
        idInterprise = strIdInterprise.toString();
        token = strToken.toString();
      });
    }
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
                    .getOnevacancie(token: token, id: widget.id),
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
                    return Padding(
                      padding: defaultPaddingHorizon,
                      child: ListView(
                        children: [
                          MainHeader(
                            maxl: 4,
                            title: "",
                            icon: Icons.arrow_back_ios,
                            onClick: () {
                              Navigator.pop(context);
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height: 100,
                                  child: Image.network(
                                    render["enterprise"]["urlbanner"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: Image.network(
                                  width: 100,
                                  height: 100,
                                  render["enterprise"]["urllogo"],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 35),
                          SecundaryText(
                            text: render["title"],
                            color: nightColor,
                            align: TextAlign.center,
                          ),
                          const SizedBox(height: 35),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubText(
                                color: nightColor,
                                text: "Descrição: \n\n${render["desc"]}",
                                align: TextAlign.start,
                              ),
                              const SizedBox(height: 25),
                              SubText(
                                color: nightColor,
                                text: "Cidade: ${render["local"]}",
                                align: TextAlign.start,
                              ),
                              const SizedBox(height: 5),
                              SubText(
                                color: nightColor,
                                text: "Vagas: ${render["vacanciesnumber"]}",
                                align: TextAlign.start,
                              ),
                              const SizedBox(height: 5),
                              SubText(
                                color: nightColor,
                                text: "Salário: ${render["value"]}R\$",
                                align: TextAlign.start,
                              ),
                            ],
                          )),
                          const SizedBox(height: 50),
                          const Divider(),
                          const SizedBox(height: 50),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    EasyLoading.showSuccess(
                                        "Você se canditadou a vaga de ${render["title"]}");
                                    RemoteAuthService().putCadidateVacancie(
                                        profileId: id,
                                        token: token,
                                        id: widget.id);
                                  },
                                  child: DefaultButton(
                                    text: "Candidatar-se",
                                    padding: defaultPadding,
                                    color: SeventhColor,
                                    colorText: lightColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
