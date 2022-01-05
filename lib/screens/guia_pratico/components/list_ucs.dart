import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/ucs_manager.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/new_ucs_screen.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/ucs_tile.dart';
import 'package:provider/provider.dart';

class ListUcs extends StatefulWidget {
  @override
  _ListUcsState createState() => _ListUcsState();
}

class _ListUcsState extends State<ListUcs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Conheça as Ucs'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NewUcsScreen()));
                  },
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Novo')),
            )
          ]),
      body: Consumer<UcsManager>(builder: (_, ucsManager, __) {
        final filteredUcs = ucsManager.filteredUcs;
        if (filteredUcs.isEmpty)
          return Center(
              child: Text(
                'Nenhum dado encontrado!',
                style: TextStyle(color: bgColor),
              ));
        return ListView.builder(
            itemCount: filteredUcs.length,
            itemBuilder: (_, index) {
              return UcsTile(filteredUcs[index]);
            });
      }),
    );
  }
}
