import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/main/about_me_screen.dart';
import 'package:gerenciador_aquifero/screens/main/especie_screen.dart';
import 'package:gerenciador_aquifero/screens/main/info_atualidades_screen.dart';
import 'package:gerenciador_aquifero/screens/main/main_screen.dart';
import 'package:gerenciador_aquifero/screens/main/pdf_screen.dart';
import 'package:gerenciador_aquifero/screens/main/suggestions_screen.dart';
import 'package:gerenciador_aquifero/screens/main/users_screen.dart';
import 'package:gerenciador_aquifero/stores/page_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) => pageController.jumpToPage(page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MainScreen(),
          UsersScreen(),
          PdfScreen(),
          InfoAtualidadesScreen(),
          EspecieScreen(),
          SuggestionsScreen(),
          AboutMeScreen(),
        ],
      ),
    );
  }
}
