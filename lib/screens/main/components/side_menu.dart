import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            DrawerListTile(
              title: "Home",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Especie",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Sugestões",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Usuarios",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Guia Prático",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Configurações",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
            ),
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
