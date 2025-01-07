import 'package:Consult/component/colors.dart';
import 'package:Consult/component/texts.dart';
import 'package:Consult/view/courses/coursescreen.dart';
import 'package:Consult/view/vacancies/vacanciescreen.dart';
import 'package:flutter/material.dart';

class VacancieCont extends StatelessWidget {
  VacancieCont(
      {super.key,
      this.subtitle,
      this.time,
      required this.title,
      this.urlThumb,
      this.maxl,
      this.over,
      this.bgcolor,
      this.price,
      this.urlLogo,
      required this.id});

  final String? subtitle;
  final String? time;
  final String title;
  final String? urlThumb;
  String id;
  int? maxl;
  String? price;
  TextOverflow? over;
  Color? bgcolor;
  String? urlLogo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          (Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VacancieScreen(
                id: id,
              ),
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: bgcolor ?? lightColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.2), // Cor e opacidade da sombra
                spreadRadius: 2, // Expansão da sombra
                blurRadius: 5, // Desfoque
                offset: Offset(0, 3), // Deslocamento (horizontal, vertical)
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SecundaryText(
                        text: title,
                        color: nightColor,
                        align: TextAlign.start,
                        maxl: maxl,
                        over: over,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SubText(
                        text: subtitle ?? "",
                        color: OffColor,
                        align: TextAlign.start,
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: SeventhColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SubText(
                            text: "Verficar",
                            align: TextAlign.center,
                            color: lightColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: urlLogo == ""
                        ? SizedBox()
                        : Image.network(
                            urlLogo ?? "",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
