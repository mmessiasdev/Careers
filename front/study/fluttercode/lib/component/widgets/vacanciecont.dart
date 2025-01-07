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
                      urlbanner: urlThumb ?? "",
                    )),
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
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: urlThumb == ""
                        ? SizedBox()
                        : Image.network(
                            urlThumb ?? "",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        color: nightColor,
                        align: TextAlign.start,
                        maxl: 8,
                        over: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SubText(
                        text: time ?? "",
                        color: OffColor,
                        align: TextAlign.start,
                        maxl: 2,
                        over: over,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SubTextSized(
                          text: price ?? "Grátis",
                          size: 26,
                          align: TextAlign.end,
                          fontweight: FontWeight.w600),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: SeventhColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SubText(
                            text: "Acessar",
                            align: TextAlign.center,
                            color: lightColor,
                          ),
                        ),
                      )
                    ],
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