import 'package:Consult/component/colors.dart';
import 'package:Consult/component/defaultButton.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:Consult/controller/auth.dart';
import 'package:Consult/service/local/auth.dart';
import 'package:Consult/service/remote/auth.dart';
import 'package:Consult/view/courses/resultexam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ExamsScreen extends StatefulWidget {
  ExamsScreen({super.key, required this.nameCourse, required this.idCourse});
  String nameCourse;
  String idCourse;

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
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

  final List<Map<String, dynamic>> questions = [
    {
      "id": 1,
      "question": "Qual é a capital da França?",
      "options": ["Paris", "Londres", "Berlim", "Roma"],
      "correctAnswer": "Paris",
    },
    {
      "id": 2,
      "question": "Quanto é 2 + 2?",
      "options": ["3", "4", "5", "6"],
      "correctAnswer": "4",
    },
    {
      "id": 3,
      "question": "Quem escreveu 'Dom Quixote'?",
      "options": [
        "Miguel de Cervantes",
        "William Shakespeare",
        "Victor Hugo",
        "Jorge Amado"
      ],
      "correctAnswer": "Miguel de Cervantes",
    },
  ];

  int currentQuestionIndex = 0;
  String? selectedOption;
  int score = 0;

  void checkAnswer() {
    final currentQuestion = questions[currentQuestionIndex];
    if (selectedOption == currentQuestion["correctAnswer"]) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
      });
    } else {
      double percentage = (score / questions.length) * 100;
      if (percentage >= 70) {
        EasyLoading.showSuccess("Certificado enviado para seu currículo!");
        RemoteAuthService().putAddCerfiticates(
          fullname: fullname,
          token: token,
          id: widget.idCourse,
          profileId: id,
        );
        // Redireciona para um `SizedBox`
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SucessExamResult(
                nameCourse: widget.nameCourse,
                resultNumber: "${percentage.toString()}%"),
          ),
        );
      } else {
        // Exibe mensagem de erro
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Resultado"),
              content:
                  const Text("Você não atingiu a pontuação mínima de 70%."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Tentar novamente"),
                ),
              ],
            );
          },
        );
        setState(() {
          currentQuestionIndex = 0;
          selectedOption = null;
          score = 0; // Reseta a pontuação para tentar novamente
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: lightColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainHeader(
                    title: "${currentQuestionIndex + 1}/${questions.length}",
                    icon: Icons.arrow_back_ios,
                    onClick: () {
                      (Navigator.pop(context));
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: SecudaryColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    SubText(
                      text: currentQuestion["question"],
                      color: nightColor,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 16),
                    ...currentQuestion["options"].map<Widget>((option) {
                      return RadioListTile<String>(
                        title: SubText(
                          text: option,
                          align: TextAlign.start,
                        ),
                        value: option,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            currentQuestionIndex == questions.length - 1
                                ? SeventhColor // Verde na última questão
                                : Theme.of(context).primaryColor, // Cor padrão
                          ),
                        ),
                        onPressed: selectedOption != null ? checkAnswer : null,
                        child: SecundaryText(
                          color: lightColor,
                          text: currentQuestionIndex == questions.length - 1
                              ? "Finalizar"
                              : "Próximo", // Altere o texto do botão na última questão
                          align: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
