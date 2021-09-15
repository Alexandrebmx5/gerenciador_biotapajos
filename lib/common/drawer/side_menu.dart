import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gerenciador_aquifero/screens/login/login_screen.dart';
import 'package:gerenciador_aquifero/stores/page_store.dart';
import 'package:gerenciador_aquifero/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';

class SideMenu extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    Future<void> verifyLoginAndSetPage(int page) async {
      if (userManagerStore.isLoggedIn) {
        pageStore.setPage(page);
      } else {
        final result = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        if (result != null && result) pageStore.setPage(page);
      }
    }

    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: DrawerHeader(
                child: Image.asset("assets/images/logo.png"),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))
                ),
              ),
            ),
            DrawerListTile(
              title: "Home",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                pageStore.setPage(0);
              },
            ),
            DrawerListTile(
              title: "Especie",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                pageStore.setPage(1);
              },
            ),
            DrawerListTile(
              title: "Sugestões",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {
                pageStore.setPage(2);
              },
            ),
            DrawerListTile(
              title: "Usuarios",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                pageStore.setPage(3);
              },
            ),
            DrawerListTile(
              title: "Guia Prático",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {
                pageStore.setPage(4);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                userManagerStore.logout();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 25,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Sair',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'v. 1.0.1',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Pricipal',
                          fontSize: 16),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    // For selecting those three line once press "Command+D"
    this.title,
    this.svgSrc,
    this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
