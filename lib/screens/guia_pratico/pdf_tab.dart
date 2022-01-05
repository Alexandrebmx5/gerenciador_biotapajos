import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/menus_guia_screen.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/pdf_tile.dart';

import 'components/pdf_header.dart';

class PdfTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PdfHeader(),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: MenusGuiaScreen()
            ),
          )
        ],
      ),
    );
  }
}
