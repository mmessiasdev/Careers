import 'package:Consult/component/colors.dart';
import 'package:Consult/component/padding.dart';
import 'package:Consult/component/texts.dart';
import 'package:flutter/material.dart';

class IconList extends StatelessWidget {
  const IconList(
      {super.key,
      required this.onClick,
      required this.icon,
      required this.title});

  final Function onClick;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: GestureDetector(
            onTap: () => onClick(),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 38,
                ),
                SubText(
                  text: title,
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class LargeIconList extends StatelessWidget {
  const LargeIconList(
      {super.key,
      required this.onClick,
      required this.icon,
      required this.title});

  final Function onClick;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: SecudaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () => onClick(),
          child: Padding(
            padding: defaultPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 38,
                ),
                SizedBox(
                  width: 15,
                ),
                SubText(
                  text: title,
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
