import 'package:Consult/component/colors.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/component/widgets/header.dart';
import 'package:flutter/material.dart';

class SucessExamResult extends StatelessWidget {
  SucessExamResult(
      {super.key, required this.nameCourse, required this.resultNumber});
  String nameCourse;
  String resultNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: Column(
        children: [
          MainHeader(title: "Finalizado!"),
          SecundaryText(
              text: 'Sua nota:', color: nightColor, align: TextAlign.center),
          SubText(text: resultNumber, align: TextAlign.center),
          SubText(
              text:
                  'Parabéns, você concluiu seu curso "${nameCourse}". Seu certificado já está pronto! Basta clicar em “Concluir” ou ir até seu perfil.',
              align: TextAlign.start),
          Image.asset(
              "https://cdni.iconscout.com/illustration/premium/thumb/happy-people-illustration-download-in-svg-png-gif-file-formats--rejoicing-man-running-woman-girl-profession-pack-illustrations-3613847.png?f=webp")
        ],
      ),
    );
  }
}
