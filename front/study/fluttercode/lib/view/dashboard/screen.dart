import 'package:Consult/service/local/auth.dart';
import 'package:Consult/view/account/account.dart';
import 'package:Consult/view/account/auth/signin.dart';
import 'package:Consult/view/search/searchdelscreen.dart';
import 'package:Consult/view/search/searchscreen.dart';
import 'package:Consult/view/vacancies/vacancies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:Consult/view/home/homepage.dart';
import 'package:get/get.dart';
import 'package:Consult/component/colors.dart';
import 'package:Consult/controller/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var token;

  @override
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
    return SizedBox(
      child: SizedBox(
          child: GetBuilder<DashboardController>(
        builder: (controller) => token == "null"
            ? SignInScreen()
            : Scaffold(
                backgroundColor: lightColor,
                body: SafeArea(
                  child: IndexedStack(
                    index: controller.tabIndex,
                    children: const [
                      HomePage(),
                      VacanciesScreen(),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                  ),
                  child: SnakeNavigationBar.color(
                    snakeShape: SnakeShape.rectangle,
                    backgroundColor: PrimaryColor,
                    unselectedItemColor: lightColor,
                    showUnselectedLabels: true,
                    selectedItemColor: OffColor,
                    snakeViewColor: PrimaryColor,
                    currentIndex: controller.tabIndex,
                    onTap: (val) {
                      controller.updateIndex(val);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                        Icons.play_arrow,
                        size: 30,
                      )),
                      BottomNavigationBarItem(
                          icon: Icon(
                        Icons.search,
                        size: 30,
                      )),
                    ],
                  ),
                ),
              ),
      )),
    );
  }
}
