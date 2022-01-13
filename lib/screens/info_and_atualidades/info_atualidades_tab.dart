import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/info_atualidades_header.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/menus_infos_atualidades_screen.dart';

class InfoAtualidadesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: InfoAtualidadesHeader(),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: MenusInfosAtualidadesScreen()
            ),
          )
        ],
      ),
    );
  }
}
