import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/trails_manager.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/new_trails_screen.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/trails_tile.dart';
import 'package:provider/provider.dart';

class ListTrails extends StatefulWidget {
  @override
  _ListTrailsState createState() => _ListTrailsState();
}

class _ListTrailsState extends State<ListTrails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Trilhas ecológicas'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NewTrailsScreen()));
                  },
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Novo')),
            )
          ]),
      body: Consumer<TrailsManager>(builder: (_, trailsManager, __) {
        final filteredTrails = trailsManager.filteredTrails;
        if (filteredTrails.isEmpty)
          return Center(
              child: Text(
                'Nenhum dado encontrado!',
                style: TextStyle(color: bgColor),
              ));
        return ListView.builder(
            itemCount: filteredTrails.length,
            itemBuilder: (_, index) {
              return TrailsTile(filteredTrails[index]);
            });
      }),
    );
  }
}
