import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/common/responsive.dart';
import 'package:gerenciador_aquifero/screens/about_me/about_me_tab.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/pdf_tab.dart';

import '../../common/drawer/side_menu.dart';

class AboutMeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: AboutMeTab(),
            ),
          ],
        ),
      ),
    );
  }
}
