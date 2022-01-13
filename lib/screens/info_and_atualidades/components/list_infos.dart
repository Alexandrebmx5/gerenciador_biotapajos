import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/info_presently/infos_manager.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/infos_tile.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/new_infos_screen.dart';
import 'package:provider/provider.dart';

class ListInfos extends StatefulWidget {
  @override
  _ListInfosState createState() => _ListInfosState();
}

class _ListInfosState extends State<ListInfos> {
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
                        MaterialPageRoute(builder: (_) => NewInfosScreen()));
                  },
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Novo')),
            )
          ]),
      body: Consumer<InfosManager>(builder: (_, infosManager, __) {
        final filteredInfos = infosManager.filteredInfos;
        if (filteredInfos.isEmpty)
          return Center(
              child: Text(
                'Nenhum dado encontrado!',
                style: TextStyle(color: bgColor),
              ));
        return ListView.builder(
            itemCount: filteredInfos.length,
            itemBuilder: (_, index) {
              return InfosTile(filteredInfos[index]);
            });
      }),
    );
  }
}
