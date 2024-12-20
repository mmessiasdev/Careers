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
    print(fullname);
    return Container(
      color: lightColor,
      child: ListView(
        children: [
          Padding(
            padding: defaultPadding,
            child: DefaultTitle(
              buttom: widget.buttom,
              title: "Meu perfil",
            ),
          ),
          Padding(
            padding: defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: OffColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 70,
                ),
                DefaultTitleButton(
                  title: email == "null" ? "Entrar na conta" : "Sair da conta",
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
        ],
      ),
    );
  }
}
