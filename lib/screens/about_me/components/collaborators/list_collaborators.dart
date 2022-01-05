import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/about_me/collaborators/collaborators_manager.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/collaborators/collaborators_tile.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/collaborators/new_colaborators_screen.dart';
import 'package:provider/provider.dart';

class ListCollaborators extends StatefulWidget {
  @override
  _ListCollaboratorsState createState() => _ListCollaboratorsState();
}

class _ListCollaboratorsState extends State<ListCollaborators> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Colaboradores'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NewCollaboratorsScreen()));
                  },
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Novo')),
            )
          ]),
      body: Consumer<CollaboratorsManager>(builder: (_, collaboratorsManager, __) {
        final filteredCollaborators = collaboratorsManager.filteredCollaborators;
        if (filteredCollaborators.isEmpty)
          return Center(
              child: Text(
                'Nenhum dado encontrado!',
                style: TextStyle(color: bgColor),
              ));
        return ListView.builder(
            itemCount: filteredCollaborators.length,
            itemBuilder: (_, index) {
              return CollaboratorsTile(filteredCollaborators[index]);
            });
      }),
    );
  }
}
