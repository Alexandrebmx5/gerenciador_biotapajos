import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/info_presently/presently_manager.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/atualidades_tile.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/new_atualidades_screen.dart';
import 'package:provider/provider.dart';

class ListAtualidades extends StatefulWidget {
  @override
  _ListAtualidadesState createState() => _ListAtualidadesState();
}

class _ListAtualidadesState extends State<ListAtualidades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Informes'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NewAtualidadesScreen()));
                  },
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Novo')),
            )
          ]),
      body: Consumer<PresentlyManager>(builder: (_, presentlyManager, __) {
        final filteredPresently = presentlyManager.filteredPresently;
        if (filteredPresently.isEmpty)
          return Center(
              child: Text(
                'Nenhum dado encontrado!',
                style: TextStyle(color: bgColor),
              ));
        return ListView.builder(
            itemCount: filteredPresently.length,
            itemBuilder: (_, index) {
              return AtualidadesTile(filteredPresently[index]);
            });
      }),
    );
  }
}
